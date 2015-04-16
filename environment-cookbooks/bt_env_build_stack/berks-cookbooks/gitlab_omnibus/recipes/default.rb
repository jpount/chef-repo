#
# Cookbook Name:: gitlab_omnibus
# Recipe:: default
#
# Copyright (c) 2015 Drew Blessing, All Rights Reserved.

# Set package URL based on version unless user set URL explicitly
if node['gitlab_omnibus']['package_url'].include?('<version>')
  node.default['gitlab_omnibus']['package_url'].gsub!(
    '<version>', node['gitlab_omnibus']['version']
  )
end
node.default['gitlab_omnibus']['package_name'] =
  node['gitlab_omnibus']['package_url'].split('/').last
package_path =
  "#{Chef::Config[:file_cache_path]}/#{node['gitlab_omnibus']['package_name']}"

unless node['gitlab_omnibus']['install_package_from_repo']
  remote_file package_path do
    source node['gitlab_omnibus']['package_url']
    mode '0644'
  end
end

execute '/usr/bin/gitlab-ctl reconfigure' do
  action :nothing
  subscribes :run, 'template[/etc/gitlab/gitlab.rb]', :immediately
end

package 'gitlab' do
  source package_path unless node['gitlab_omnibus']['install_package_from_repo']
  action :install
  # apt can't handle a source attribute
  if node['platform'] == 'centos'
    provider Chef::Provider::Package::Rpm
  elsif node['platform'] =~ /debian|ubuntu/
    provider Chef::Provider::Package::Dpkg
  end
  # reconfigure on upgrade (won't have effect on 1st install)
  notifies :run, 'execute[/usr/bin/gitlab-ctl reconfigure]', :delayed
end

template '/etc/gitlab/gitlab.rb' do
  source 'gitlab.rb.erb'
  variables(
    'external_url'      => node['gitlab_omnibus']['external_url'],
    'gitlab_rails'      => node['gitlab_omnibus']['gitlab_rails'],
    'user'              => node['gitlab_omnibus']['user'],
    'unicorn'           => node['gitlab_omnibus']['unicorn'],
    'sidekiq'           => node['gitlab_omnibus']['sidekiq'],
    'gitlab_shell'      => node['gitlab_omnibus']['gitlab_shell'],
    'postgresql'        => node['gitlab_omnibus']['postgresql'],
    'redis'             => node['gitlab_omnibus']['redis'],
    'web_server'        => node['gitlab_omnibus']['web_server'],
    'nginx'             => node['gitlab_omnibus']['nginx'],
    'logging'           => node['gitlab_omnibus']['logging'],
    'logrotate'         => node['gitlab_omnibus']['logrotate'],
    'omnibus_gitconfig' => node['gitlab_omnibus']['omnibus_gitconfig'],
    'ci_external_url'   => node['gitlab_omnibus']['ci_external_url'],
    'gitlab_ci'         => node['gitlab_omnibus']['gitlab_ci'],
    'ci_unicorn'        => node['gitlab_omnibus']['ci_unicorn'],
    'ci_sidekiq'        => node['gitlab_omnibus']['ci_sidekiq'],
    'ci_redis'          => node['gitlab_omnibus']['ci_redis'],
    'ci_nginx'          => node['gitlab_omnibus']['ci_nginx']
  )
end

service 'gitlab' do
  start_command '/usr/bin/gitlab-ctl start'
  stop_command '/usr/bin/gitlab-ctl stop'
  status_command '/usr/bin/gitlab-ctl status'
  restart_command '/usr/bin/gitlab-ctl restart'
  action :start
  supports restart: true, status: true
  provider Chef::Provider::Service::Simple
end
