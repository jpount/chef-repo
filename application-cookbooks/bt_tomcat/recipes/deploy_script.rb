#
# Cookbook Name:: tomcat
# Recipe:: deploy_script
#
#

case node['platform_family']
when 'rhel', 'fedora', 'redhat'
  bash "install wget and curl" do
    code <<-EOF
       sudo yum install -y curl 
       sudo yum install -y wget 
    EOF
  end
end

template "#{node["tomcat"]["config_dir"]}/deploy_app.sh" do
  source 'deploy.sh.erb'
  owner 'root'
  group 'root'
  mode  '0755'
end


