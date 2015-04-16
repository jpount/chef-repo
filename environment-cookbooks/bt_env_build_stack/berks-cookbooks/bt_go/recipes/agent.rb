# Cookbook Name:: bt_go
# Recipe:: agent

case node['platform']
when 'windows'
  include_recipe 'bt_go::agent_windows'
else
  include_recipe 'bt_go::agent_linux'
end
