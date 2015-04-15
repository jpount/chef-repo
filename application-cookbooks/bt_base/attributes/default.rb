############
# Settings #
############

# Fill this four in using environment variables
#role=$CHEF_ROLE
#environment=$CHEF_ENV
#origin=$CHEF_GIT
#branch=$CHEF_ENV_BRANCH
# Defaults below
default[:bt_base][:chef][:role] = 'cookbook_role'
default[:bt_base][:chef][:environment] = 'production'
default[:bt_base][:git][:branch] = 'master'
default[:bt_base][:git][:origin] = 'https://github.com/jpount/chef-repo.git'

# Chef installation directory
default[:bt_base][:chef][:dir] = '/etc/chef'
default[:bt_base][:chef][:data_bag_secret] = '/home/john/work/chef/sample_repo/data_bags'
default[:bt_base][:chef][:version] = '11.4.0'
default[:bt_base][:chef][:package_source] = 'http://www.opscode.com/chef/download?p=${platform}&pv=${platform_version}&m=${arch}&v=${chef_version}&prerelease=false'

default[:bt_base][:git][:key] = '/path/to/chef/deploy/key'
default[:bt_base][:converge][:dir] = '/usr/local/bin/first_converge'
default[:bt_base][:bootstrap][:dir] = '/usr/local/bin/bootstrap_script'
default[:bt_base][:ubuntu] = false
default[:bt_base][:last_bootstrap_line] = "Bootstrapping done - thanks Airbnb"



default[:bt_base][:testcreatename] = "filenamefromatts"


