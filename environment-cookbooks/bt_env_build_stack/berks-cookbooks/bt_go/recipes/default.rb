# Since we're running on a single node we can just use 127.0.0.1 for the server IP. Search isn't necessary

case node['platform']
when 'windows'
  include_recipe "bt_go::agent_windows"
else
  include_recipe "bt_go::server"
  include_recipe "bt_go::agent_linux"
end

Chef::Log.info("Node has #{node['cpu']['total']} CPUs")
