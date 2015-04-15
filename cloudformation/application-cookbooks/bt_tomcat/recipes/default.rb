#
# Cookbook Name:: bt_tomcat
# Recipe:: default
#
# Copyright (c) 2015 The Authors, All Rights Reserved.

include_recipe 'tomcat'
include_recipe 'bt_java'
include_recipe 'bt_tomcat::users'
include_recipe 'bt_tomcat::deploy_script'
include_recipe 'bt_tomcat::customise_server'

