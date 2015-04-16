#<
# Specify GitLab version to install. This is ignored if package_url is specified
#>
default['gitlab_omnibus']['version'] = '7.9.2'
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

puts "platform .... #{node['platform']}"

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
when 'amazon'
    default['gitlab_omnibus']['package_url'] =
      'https://downloads-packages.s3.amazonaws.com/debian-7.8/gitlab_<version>-omnibus-1_amd64.deb'
when 'redhat'
  default['gitlab_omnibus']['package_url'] =
    'https://downloads-packages.s3.amazonaws.com/centos-7.0.1406/gitlab-<version>_omnibus-1.el7.x86_64.rpm'
else
  Chef::Log.fatal(
    '"gitlab_omnibus" cookbook currently does not support this operating system'
  )
end

# GitLab Configuration
#<> URL where GitLab will be accessible - add an "s" for https but you need to provide a cert
# https://gitlab.com/gitlab-org/omnibus-gitlab/blob/629def0a7a26e7c2326566f0758d4a27857b52a3/doc/settings/nginx.md
default['gitlab_omnibus']['external_url'] = "http://#{node['fqdn']}"
default['gitlab_omnibus']['backup']['enable'] = true

