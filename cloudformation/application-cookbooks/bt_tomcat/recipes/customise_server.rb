#
# Cookbook Name:: tomcat
# Recipe:: customise_server
#
# Add the Sparrow stuff to the Tomcat installation
#
cookbook_file "aspectjrt-1.7.2.jar" do
  path "#{node["tomcat"]["endorsed_dir"]}/aspectjrt-1.7.2.jar"
  action :create_if_missing
end

cookbook_file "aspectjweaver-1.7.2.jar" do
  path "#{node["tomcat"]["endorsed_dir"]}/aspectjweaver-1.7.2.jar"
  action :create_if_missing
end

cookbook_file "j2ee-6.0.jar" do
  path "#{node["tomcat"]["endorsed_dir"]}/j2ee-6.0.jar"
  action :create_if_missing
end

cookbook_file "sparrow-security-1.0.8a.jar" do
  path "#{node["tomcat"]["endorsed_dir"]}/sparrow-security-1.0.8a.jar"
  action :create_if_missing
end

cookbook_file "validation-api-1.0.0.GA.jar" do
  path "#{node["tomcat"]["endorsed_dir"]}/validation-api-1.0.0.GA.jar"
  action :create_if_missing
end

cookbook_file "websphereHelper-1.0.jar" do
  path "#{node["tomcat"]["endorsed_dir"]}/websphereHelper-1.0.jar"
  action :create_if_missing
end

# create the properties directory
directory "#{node["tomcat"]["home"]}/properties" do
  owner '#{node["tomcat"]["user"]}'
  group '#{node["tomcat"]["group"]}'
  mode '0777'
  action :create
end

# change the catalina.properties file
template "#{node["tomcat"]["config_dir"]}/catalina.properties" do
  source 'catalina.properties.erb'
  owner 'root'
  group 'root'
  mode  '0755'
end

