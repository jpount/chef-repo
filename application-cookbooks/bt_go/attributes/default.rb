###############
# Go Settings #
###############

default['go']['backup_path'] = ''
default['go']['backup_retrieval_type'] = 'local'

# Server set autoregister (store values in Chef Server)
default['go']['auto_register_agents']          = true
default['go']['server']['auto_register_key']    = '1234567890abcde'

# Autoconfigure agents
default['go']['agent']['auto_register']        = true
# Default Agent auto register key
default['go']['agent']['auto_register_key']    = '1234567890abcde'
default['go']['agent']['auto_register_resources'] = []
default['go']['agent']['auto_register_environments'] = []
#default['go']['agent']['server_host'] = '127.0.0.1'
default['go']['agent']['server_host'] = 'go.server.dev.local'

# Install this many agent instances on a box - default is one per CPU
default['go']['agent']['instance_count'] = node['cpu']['total']
default['go']['agent']['server_search_query'] =
  "chef_environment:#{node.chef_environment} AND recipes:go\\:\\:server"

default['go']['version']                       = '14.3.0-1186'

unless platform?('windows')
  default['go']['agent']['java_home']          = '/usr/bin/java'
end

default['go']['server']['install_path'] = 'C:\Program Files (x86)\Go Server'
default['go']['server'] = '127.0.0.1'


