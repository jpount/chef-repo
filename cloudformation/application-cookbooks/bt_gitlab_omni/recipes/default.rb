#
# Cookbook Name:: bt_gitlab_omni
# Recipe:: default
#
# Copyright (c) 2015 The Authors, All Rights Reserved.

# Note that this recipe requires ssh recipes (default, configure_gitlab) for the cloud deployment so configure them in the role
include_recipe 'bt_gitlab_omni::pre_install'
include_recipe 'gitlab_omnibus::default'

