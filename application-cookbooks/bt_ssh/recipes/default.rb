#
# Cookbook Name:: bt_ssh
# Recipe:: default
#
# Copyright (c) 2015 The Authors, All Rights Reserved.

# create ssh key in the home directory
execute "generate ssh key for #{node['bt_ssh']['user']}" do
  user node[:bt_ssh][:user]
  creates "/home/#{node['bt_ssh']['user']}/.ssh/id_rsa"
  command "ssh-keygen -t rsa -q -f /home/#{node['bt_ssh']['user']}/.ssh/id_rsa -P ''"
end

