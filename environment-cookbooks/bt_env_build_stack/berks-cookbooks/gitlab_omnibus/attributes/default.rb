#<
# Specify GitLab version to install. This is ignored if package_url is specified
#>
default['gitlab_omnibus']['version'] = '7.8.1'
#<
# Set to true if using an internal or hosted Yum/Apt repository
# with the GitLab Omnibus package. Enabling this option assumes
# the yum/apt repo is already configured on the host.
#>
default['gitlab_omnibus']['install_package_from_repo'] = false

#<
# Determine package URL based on specified version
# and platform/platform version.
#>
default['gitlab_omnibus']['package_url'] = ''

case node['platform']
when 'centos'
  case node['platform_version']
  when /6\.\d/
    default['gitlab_omnibus']['package_url'] =
      'https://downloads-packages.s3.amazonaws.com/centos-6.6/gitlab-<version>_omnibus-1.el6.x86_64.rpm'
  when /7\.\d/
    default['gitlab_omnibus']['package_url'] =
      'https://downloads-packages.s3.amazonaws.com/centos-7.0.1406/gitlab-<version>_omnibus-1.el7.x86_64.rpm'
  else
    Chef::Log.fatal(
      '"gitlab_omnibus" cookbook currently does not support this version of CentOS'
    )
  end
when 'ubuntu'
  case node['platform_version']
  when '12.04'
    default['gitlab_omnibus']['package_url'] =
      'https://downloads-packages.s3.amazonaws.com/ubuntu-12.04/gitlab_<version>-omnibus-1_amd64.deb'
  when '14.04'
    default['gitlab_omnibus']['package_url'] =
      'https://downloads-packages.s3.amazonaws.com/ubuntu-14.04/gitlab_<version>-omnibus-1_amd64.deb'
  else
    Chef::Log.fatal(
      '"gitlab_omnibus" cookbook currently does not support this version of Ubuntu'
    )
  end
when 'debian'
  case node['platform_version']
  when /7\.\d/
    default['gitlab_omnibus']['package_url'] =
      'https://downloads-packages.s3.amazonaws.com/debian-7.8/gitlab_<version>-omnibus-1_amd64.deb'
  else
    Chef::Log.fatal(
      '"gitlab_omnibus" cookbook currently does not support this version of Debian'
    )
  end
else
  Chef::Log.fatal(
    '"gitlab_omnibus" cookbook currently does not support this operating system'
  )
end

# GitLab Configuration

#<> URL where GitLab will be accessible
default['gitlab_omnibus']['external_url'] = "https://#{node['fqdn']}"
#<> Configuration matching `gitlab_rails['config_key']` from `gitlab.rb.template`
default['gitlab_omnibus']['gitlab_rails'] = {}
#<> Configuration matching `user['config_key']` from `gitlab.rb.template`
default['gitlab_omnibus']['user'] = {}
#<> Configuration matching `unicorn['config_key']` from `gitlab.rb.template`
default['gitlab_omnibus']['unicorn'] = {}
#<> Configuration matching `sidekiq['config_key']` from `gitlab.rb.template`
default['gitlab_omnibus']['sidekiq'] = {}
#<> Configuration matching `gitlab_shell['config_key']` from `gitlab.rb.template`
default['gitlab_omnibus']['gitlab_shell'] = {}
#<> Configuration matching `postgresql['config_key']` from `gitlab.rb.template`
default['gitlab_omnibus']['postgresql'] = {}
#<> Configuration matching `redis['config_key']` from `gitlab.rb.template`
default['gitlab_omnibus']['redis'] = {}
#<> Configuration matching `web_server['config_key']` from `gitlab.rb.template`
default['gitlab_omnibus']['web_server'] = {}
#<> Configuration matching `nginx['config_key']` from `gitlab.rb.template`
default['gitlab_omnibus']['nginx'] = {}
#<> Configuration matching `logging['config_key']` from `gitlab.rb.template`
default['gitlab_omnibus']['logging'] = {}
#<> Configuration matching `logrotate['config_key']` from `gitlab.rb.template`
default['gitlab_omnibus']['logrotate'] = {}
#<> Configuration matching `omnibus_gitconfig['config_key']` from `gitlab.rb.template`
default['gitlab_omnibus']['omnibus_gitconfig'] = {}

# GitLab CI

#<> URL where GitLab CI will be accessible. Setting this value enables/configures GitLab CI
default['gitlab_omnibus']['ci_external_url'] = nil
#<> Configuration matching `gitlab_ci['config_key']` from `gitlab.rb.template`
default['gitlab_omnibus']['gitlab_ci'] = {}
#<> Configuration matching `ci_unicorn['config_key']` from `gitlab.rb.template`
default['gitlab_omnibus']['ci_unicorn'] = {}
#<> Configuration matching `ci_sidekiq['config_key']` from `gitlab.rb.template`
default['gitlab_omnibus']['ci_sidekiq'] = {}
#<> Configuration matching `ci_redis['config_key']` from `gitlab.rb.template`
default['gitlab_omnibus']['ci_redis'] = {}
#<> Configuration matching `ci_nginx['config_key']` from `gitlab.rb.template`
default['gitlab_omnibus']['ci_nginx'] = {}
