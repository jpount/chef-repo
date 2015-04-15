case node['platform_family']
when 'debian'
  include_recipe 'apt'

  apt_repository 'thoughtworks' do
    uri 'http://download.go.cd/gocd-deb/'
    components ['/']
  end

  package_options = '--force-yes'
when 'redhat','rhel','fedora'
  include_recipe 'yum'
  yum_repository 'thoughtworks' do
    baseurl 'http://download.go.cd/gocd-rpm'
    gpgcheck false
  end
end

include_recipe 'java'

package 'unzip'

package "go-server" do
  version node['go']['version']
  options package_options
  notifies :start, 'service[go-server]', :immediately
end

# If we're upgrading an existing Go Server then leave the configuration and such intact. 
# If it's a new node, and a SVN backup URL is specified then restore/overwrite any existing configuration.

# Detection isn't based on the <license> element as Go-Community edition has no license. 
# We look for at least one <pipelines> element, with the assumption that if you have a backup you have at least one pipeline.

if (::File.exists?('/etc/go/cruise-config.xml') and ::File.readlines('/etc/go/cruise-config.xml').grep(/<pipelines/).length > 0) 
  skip_backup = true
  Chef::Log.warn("Existing configuration detected. Restore skipped.")
else
  Chef::Log.warn("New install detected.")
  skip_backup = false
  restore_go_config = false
  if (node['go']['backup_path'] && !node['go']['backup_path'].strip.empty?) 
    Chef::Log.warn("Backup URL specified. Configuration will be restored.")
    restore_go_config = true
  end
end

Chef::Log.warn("Backup process")
if node['go']['backup_retrieval_type'] =~ /subversion|svn/i
  # Grab the backup out of Subversion
  Chef::Log.warn("Backup from SVN")
  subversion "restore-go-config" do
    Chef::Log.info("Restoring configuration from #{node['go']['backup_path']}")
    repository node['go']['backup_path']
    destination "#{Chef::Config[:file_cache_path]}/go-config-restore"
    action :force_export
    notifies :stop, 'service[go-server-control]', :immediately
    not_if {skip_backup}
    only_if {restore_go_config}
  end
elsif node['go']['backup_retrieval_type'] =~ /local/i and ::File.directory?(node['go']['backup_path'])
  Chef::Log.warn("Backup from file - use #{node['go']['backup_path']}")
  directory "#{Chef::Config[:file_cache_path]}/go-config-restore/go-config/current" do
    mode 0755
    recursive true
    action :create
  end

  Chef::Log.warn("Backup from file")
  ruby_block "copy_local_file" do
    block do
      if ::File.exists?("#{node['go']['backup_path']}/db.zip")
        ::FileUtils.cp "#{node['go']['backup_path']}/db.zip", "#{Chef::Config[:file_cache_path]}/go-config-restore/go-config/current"
      end
      if ::File.exists?("#{node['go']['backup_path']}/config-dir.zip")
        ::FileUtils.cp "#{node['go']['backup_path']}/config-dir.zip", "#{Chef::Config[:file_cache_path]}/go-config-restore/go-config/current"
      end
      if ::File.exists?("#{node['go']['backup_path']}/config-repo.zip")
        ::FileUtils.cp "#{node['go']['backup_path']}/config-repo.zip", "#{Chef::Config[:file_cache_path]}/go-config-restore/go-config/current"
      end
    end
  end
end

# Trash and restore the H2 Database
file "/var/lib/go-server/db/h2db/cruise.h2.db" do
  action :delete
  not_if {skip_backup}
  only_if {restore_go_config}
end

execute "restore_db" do
  Chef::Log.info("Restoring h2db")
  command "unzip -q -u -o #{Chef::Config[:file_cache_path]}/go-config-restore/go-config/current/db.zip -d  /var/lib/go-server/db/h2db"
  user "go"
  group "go"
  action :run
  not_if {skip_backup}
  only_if {restore_go_config}
end

# Trash and restore the /etc/go configuration.  Noted side-effect of this approach is that /etc/go is owned by Go, not root.
directory "/etc/go" do
  action :delete
  recursive true
  not_if {skip_backup}
  only_if {restore_go_config}
end
directory "/etc/go" do
  action :create
  user "go"
  group "go"
  not_if {skip_backup}
  only_if {restore_go_config}
end
execute "restore_config" do
  command "unzip -q -u -o #{Chef::Config[:file_cache_path]}/go-config-restore/go-config/current/config-dir.zip -d  /etc/go"
  user "go"
  group "go"
  action :run
  not_if {skip_backup}
  only_if {restore_go_config}
end

# Trash and restore the internal Git repo that's really the source of the pipeline config.  Once this completes fire up Go.
directory "/var/lib/go-server/db/config.git" do
  action :delete
  recursive true
  not_if {skip_backup}
  only_if {restore_go_config}
end
directory "/var/lib/go-server/db/config.git" do
  action :create
  user "go"
  group "go"
  not_if {skip_backup}
  only_if {restore_go_config}
end
execute "restore_config_repo" do
  command "unzip -q -u -o #{Chef::Config[:file_cache_path]}/go-config-restore/go-config/current/config-repo.zip -d  /var/lib/go-server/db/config.git"
  user "go"
  group "go"
  action :run
  not_if {skip_backup}
  only_if {restore_go_config}
  notifies :restart, 'service[go-server]', :immediately
end

# Used for stop/start in-process
service 'go-server-control' do
  service_name 'go-server'
  action :nothing
end

# Used for the lasting service config
service 'go-server' do
  supports :status => true, :restart => true, :reload => true, :start => true
  action [:enable, :nothing]
  notifies :get, 'http_request[verify_go-server_comes_up]', :immediately
end

http_request 'verify_go-server_comes_up' do
  url 'http://localhost:8153/go/home'
  retry_delay 10
  retries 10
  action :nothing
end

