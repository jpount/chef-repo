#
# Cookbook Name:: bt_gitlab_omni
# Recipe:: default
#
# Copyright (c) 2015 The Authors, All Rights Reserved.

# Note that this recipe requires ssh recipes (default, configure_gitlab) for the cloud deployment so configure them in the role

#include_recipe 'openssh'
#include_recipe 'postfix'

case node['platform_family']
when 'rhel', 'fedora', 'redhat', 'centos'
  bash "install pre-reqs" do
    code <<-EOF
	sudo yum -y install openssh-server
	sudo yum -y install postfix
	sudo yum -y install cronie
	sudo yum -y install lokkit
	sudo service -y postfix start
	sudo chkconfig postfix on
	sudo lokkit -s http -s ssh
    EOF
  end
else
  Chef::Log.fatal(
    '"gitlab_omnibus" nothing to do'
  )
end

