#
# Cookbook Name:: bt_ssh
# Recipe:: configure_git
#
# Copyright (c) 2015 The Authors, All Rights Reserved.

# set up the git auth keys
Chef::Log.info("Create the directory...")

bash "configure git" do
  # sudo -s -u git
  # this will be run as root
  code <<-EOF
     cp /home/#{node['bt_ssh']['user']}/.ssh/id_rsa.pub /tmp
     sudo adduser git
     mkdir /home/git/.ssh && chmod 700 /home/git/.ssh
     touch /home/git/.ssh/authorized_keys && chmod 600 /home/git/.ssh/authorized_keys
     cat /tmp/id_rsa.pub >> /home/git/.ssh/authorized_keys
     chown -R git:git /home/git
  EOF
end


