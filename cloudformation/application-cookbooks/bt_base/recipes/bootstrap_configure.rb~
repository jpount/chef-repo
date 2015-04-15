#
# Cookbook Name:: bt_base
# Recipe:: default
#
# Copyright (c) 2015 The Authors, All Rights Reserved.

# create the chef directory
Chef::Log.info("Create the directory...")
directory node[:bt_base][:bootstrap][:dir] do
  owner   user
  group   group
  mode    00755
  recursive true
  action :create
end

Chef::Log.info("Create the script...")
template "#{node[:bt_base][:bootstrap][:dir]}/bootstrap.sh" do
  source  'bootstrap.sh.erb'
  mode  '644'
end

Chef::Log.info("Set permissions...")
execute "chmod" do
  command "chmod -R 755 #{node[:bt_base][:bootstrap][:dir]}"
  action :run
end

Chef::Log.info("Create SSH key...")
include_recipe "bt_ssh::default"

Chef::Log.info("Done!")

