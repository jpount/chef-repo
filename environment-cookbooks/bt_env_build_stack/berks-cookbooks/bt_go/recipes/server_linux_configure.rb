# Always run the publish/remove autoregister key blocks so that if the attribute gets changed dynamically we still work properly.
# If it's not run every time we could leave the autoregister key in the attributes which would be bad.  Mmm'kay?
if (Chef::Config[:solo])
  Chef::Log.warn("Automatic agent registration is not supported on chef-solo.  All attributes must be set on the agent node directly.")
end

ruby_block "publish_autoregister_key" do
  block do
    s = ::File.readlines('/etc/go/cruise-config.xml').grep(/agentAutoRegisterKey="(\S+)"/)
    if (s.length > 0)
      server_autoregister_key=s[0].to_s.match(/agentAutoRegisterKey="(\S+)"/)[1]
    else
      server_autoregister_key=""
    end
    node.set['go']['autoregister_key']=server_autoregister_key
    # This will write to the chef server
    node.save
  end
  action :create
  only_if {node['go']['auto_register_agents']}
  not_if {Chef::Config[:solo]}
end

ruby_block "remove_autoregister_key" do
  block do
    node.set['go']['autoregister_key']=""
    # This will write to the chef server
    node.save
  end
  action :create
  not_if {node['go']['auto_register_agents']}
  not_if {Chef::Config[:solo]}
end
