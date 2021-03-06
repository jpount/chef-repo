#
# Cookbook Name:: bt_base_image
# Recipe:: default
#
# Copyright (c) 2015 The Authors, All Rights Reserved.

case node['platform_family']
when 'ubuntu'
  # nothing to do
else
  include_recipe 'yum'
end

include_recipe 'bt_java'
include_recipe 'git::default'

case node['platform_family']
when 'rhel', 'fedora', 'redhat'
  bash "install wget and curl" do
    code <<-EOF
       sudo yum install -y curl 
       sudo yum install -y wget 
    EOF
  end
end
