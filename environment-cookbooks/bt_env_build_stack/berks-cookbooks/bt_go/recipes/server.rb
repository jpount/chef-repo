# Cookbook Name:: go
# Recipe:: server

case node['platform']
when 'windows'
  include_recipe 'bt_go::server_windows'
else
  include_recipe 'bt_go::server_linux'
  include_recipe 'bt_go::server_linux_configure'
end
