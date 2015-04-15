#
# Cookbook Name:: bt_ssh
# Recipe:: configure_gitlab
#
# Copyright (c) 2015 The Authors, All Rights Reserved.

# set up the git auth keys
Chef::Log.info("Create the directory...")

bash "configure git" do
  # sudo -s -u git
  # this will be run as root
  # installation will be at /var/opt/gitlab
  # .ssh dir will already be created
  code <<-EOF
     cp /home/#{node['bt_ssh']['user']}/.ssh/id_rsa.pub /tmp
     cat /tmp/id_rsa.pub >> /var/opt/gitlab/.ssh/authorized_keys
  EOF
end
