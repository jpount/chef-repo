# Cookbook Name:: bt_go
# Recipe:: agent_linux_bootstrap_reconfigure
#
# Run this if you want want to reconfigure the agent on bootstrap of an instance (ie AWS CF)
#

case node['platform_family']
when 'debian'
  include_recipe 'apt'
when 'redhat','rhel','fedora'
  include_recipe 'yum'
end

go_server_autoregister  = node['go']['agent']['auto_register']
autoregister_key        = node['go']['agent']['auto_register_key']

Chef::Log.warn("Vars ... ")
Chef::Log.warn("go_server_autoregister #{go_server_autoregister} ")
Chef::Log.warn("autoregister_key #{autoregister_key} ")

# If running under solo or user specifed the server host, try and use that
if Chef::Config['solo'] || node['go']['agent'].attribute?('server_host')
  Chef::Log.info("Attempting to use node['go']['agent']['server_host'] attribute " +
    "for server host")
  go_server_host = node['go']['agent']['server_host']
  # JP - set for chef solo
  go_server_autoregister = node['go']['auto_register_agents']
  Chef::Log.info("Found Go server at ip address #{go_server_host} with automatic agent registration=#{go_server_autoregister}")
  if (go_server_autoregister)
    Chef::Log.warn("Agent auto-registration enabled.  This agent will not require approval to become active.")
    autoregister_key = node['go']['agent']['auto_register_key']
    Chef::Log.warn("Agent auto-registrated with #{autoregister_key}")
  else
    autoregister_key = ""
  end
end

# Ensure we have a Go server host set to a sensible default
if go_server_host.nil?
  go_server_host = '127.0.0.1'
  Chef::Log.warn("Go server not found on Chef server or not specifed via " +
    "node['go']['agent']['server_host'] attribute, defaulting Go server to #{go_server_host}")
end

(1..node['go']['agent']['instance_count']).each do |i|
  log "Configuring Go agent # #{i} of #{node['go']['agent']['instance_count']} for Go server at #{go_server_host}:8153 "
  if (i < 2)
    suffix = ""
  else
    suffix = "-#{i}"
  end
  
  template "/etc/init.d/go-agent#{suffix}" do
    # <%= @go_agent_instance -%>
    source 'go-agent-service.erb'
    mode '0755'
    owner 'root'
    group 'root'
    variables(:go_agent_instance => suffix)
  end

  template "/etc/default/go-agent#{suffix}" do
    source 'go-agent-defaults.erb'
    mode '0644'
    owner 'go'
    group 'go'
    variables(:go_server_host => go_server_host, 
      :go_server_port => '8153', 
      :java_home => node['java']['java_home'],
      :work_dir => "/var/lib/go-agent#{suffix}")
  end
  
  template "/usr/share/go-agent/agent#{suffix}.sh" do
    source 'go-agent-sh.erb'
    mode '0755'
    owner 'go'
    group 'go'
    variables(:go_server_host => go_server_host, :go_agent_instance => suffix)
  end

  log "Registering agent#{suffix} with autoregister key of " + autoregister_key

  directory "/var/log/go-agent#{suffix}" do
    mode '0755'
    owner 'go'
    group 'go'
  end

  directory "/var/lib/go-agent#{suffix}" do
    mode '0755'
    owner 'go'
    group 'go'
  end

  directory "/var/lib/go-agent#{suffix}/config" do
    mode '0755'
    owner 'go'
    group 'go'
  end
  
  autoregister_resources = []
  node['go']['agent']['auto_register_resources'].each do |resource_key|
    autoregister_resources.push(resource_key)
  end

  autoregister_environments = []
  node['go']['agent']['auto_register_environments'].each do |env_key|
    autoregister_environments.push(env_key)
  end

  autoregister_resources.push(node['os'], node['platform'], "#{node['platform']}-#{node['platform_version']}")

  log "Registering agent with resource tags: #{autoregister_resources} and environments: #{autoregister_environments}"

  template "/var/lib/go-agent#{suffix}/config/autoregister.properties" do
    source 'autoregister.properties.erb'
    mode '0644'
    group 'go'
    owner 'go'
    variables(
      :autoregister_key => autoregister_key,
      :agent_resources => autoregister_resources.join(","),
      :agent_environments => autoregister_environments.join(","))
  end

  service "go-agent#{suffix}" do
    supports :status => true, :restart => true, :reload => true, :start => true
    action :nothing
    subscribes :enable, "template[/etc/init.d/go-agent#{suffix}]"
    subscribes :enable, "template[/var/lib/go-agent#{suffix}/config/autoregister.properties]"
    subscribes :enable, "template[/etc/default/go-agent#{suffix}]"
    subscribes :restart, "template[/etc/init.d/go-agent#{suffix}]"
    subscribes :restart, "template[/var/lib/go-agent#{suffix}/config/autoregister.properties]"
    subscribes :restart, "template[/etc/default/go-agent#{suffix}]"
  end
  
end


