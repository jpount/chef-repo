# Cookbook Name:: bt_go
# Recipe:: agent_linux_ruby
# Description:: Installs ruby and Chef related testing tools
#

Chef::Log.warn("Install Ruby components ... ")
include_recipe 'bt_ruby:default'


