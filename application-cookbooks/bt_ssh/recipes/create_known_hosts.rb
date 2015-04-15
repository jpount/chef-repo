#
# Cookbook Name:: bt_ssh
# Recipe:: create_known_hosts
#
# Copyright (c) 2015 The Authors, All Rights Reserved.

# add git to known hosts, so future deploys won't be interrupted
execute "add_git_to_known_hosts" do
  action :run
  user node[:bt_ssh][:user]
  command "ssh-keyscan -H #{node['bt_ssh']['git']['domain']} >> /home/#{node[:bt_ssh][:user]}/.ssh/known_hosts"
end

# add gitlab to known hosts, so future deploys won't be interrupted
execute "add_gitlab_to_known_hosts" do
  action :run
  user node[:bt_ssh][:user]
  command "ssh-keyscan -H #{node['bt_ssh']['gitlab']['domain']} >> /home/#{node[:bt_ssh][:user]}/.ssh/known_hosts"
end

