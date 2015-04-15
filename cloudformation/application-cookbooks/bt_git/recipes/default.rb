#
# Cookbook Name:: remote_git
# Recipe:: default
#
# Copyright (c) 2015 The Authors, All Rights Reserved.

# Note that this recipe requires ssh recipes (default, configure_git) for the cloud deployment so configure them in the role
include_recipe 'git::default'

