# Description

Install and configure GitLab and GitLab CI using GitLab Omnibus packages. GitLab
Omnibus packages contain all dependencies needed to run GitLab including Ruby,
PostgreSQL database, etc.

This cookbook is in the early stages. Please try it out and provide
feedback in the issue tracker if you have trouble.

[Issue Tracker](https://gitlab.com/dblessing/chef-gitlab_omnibus/issues)

## Getting Started

By default, this cookbook does not require any attributes to be set. Simply
include this recipe in a wrapper cookbook or on a node and GitLab will be
installed and configured with `external_url` set to `https://#{node['fqdn']}`.
Override `node['gitlab_omnibus']['external_url']` if the default doesn't fit
your needs.

GitLab CI is not enabled/configured by default. Set
`node['gitlab_omnibus']['ci_external_url']` to enable GitLab CI.

All other configuration values default to the values specified in the GitLab
Omnibus package. See
[gitlab.rb.template](https://gitlab.com/gitlab-org/omnibus-gitlab/blob/master/files/gitlab-config-template/gitlab.rb.template)
in the GitLab Omnibus repository for default values. For each configuration
key in the template file there is a configuration hash in this cookbook. For
example, to set `gitlab_rails['gitlab_ssh_host']` use
`node['gitlab_omnibus']['gitlab_rails']['gitlab_ssh_host'] = ''`. Similarly,
to set `unicorn['port']` use `node['gitlab_omnibus']['unicorn']['port'] = 8181`.

Values represented in YAML format in `gitlab.rb.template` should be transformed
into nested hashes before being passed in to attributes in this cookbook. One
example of this is the `gitlab_rails['ldap_servers']` configuration key.

## Enterprise GitLab

This cookbook supports installation of GitLab EE in addition to CE. Enterprise
users *must* set `node['gitlab_omnibus']['package_url']`. The package URL can
be obtained from the GitLab EE repository once you have subscription access.

## SSL

Omnibus has some magic in it. If you set an `external_url` to some value with
'https' in it Omnibus will enable SSL in Nginx configuration. By default, this
points at `/etc/gitlab/ssl/#{node['fqdn']}.crt` for the certificate and
`/etc/gitlab/ssl/#{node['fqdn']}.key` for the private key. Users of this
cookbook should either place SSL certificates in this location or specify
a new location for certificates with
`node['gitlab_omnibus']['nginx']['ssl_certificate']` and
`node['gitlab_omnibus']['nginx']['ssl_certificate_key']`. This cookbook does
not facilitate handling of SSL certificate files. See
["Things this cookbook doesn't do"](#things-this-cookbook-doesn-t-do) below for
more information.

If GitLab CI is enabled, SSL configuration options for the CI virtual host
should be set. Set `node['gitlab_omnibus']['ci_nginx']['ssl_certificate']` and
`node['gitlab_omnibus']['ci_nginx']['ssl_certificate_key']`. The default
is the same as for GitLab - `/etc/gitlab/ssl/#{node['fqdn']}.crt` for the
certificate and `/etc/gitlab/ssl/#{node['fqdn']}.key` for the private key.

## SSH

GitLab requires OpenSSH. I suggest the
[openssh cookbook](https://supermarket.chef.io/cookbooks/openssh) for managing
SSH. Installing and configuring SSH is outside the scope of this cookbook. See
["Things this cookbook doesn't do"](#things-this-cookbook-doesn-t-do) below for
more information.

## Postfix

GitLab requires Postfix to send email. I recommend the
[postfix cookbook](https://supermarket.chef.io/cookbooks/postfix) for managing
Postfix. Installing and configuring Postfix is outside the scope of this
cookbook. See
["Things this cookbook doesn't do"](#things-this-cookbook-doesn-t-do) below for
more information.

# Requirements

## Platform:

* Centos (>= 6.5)
* Debian (>= 7.1)
* Ubuntu (>= 12.04)

## Cookbooks:

*No dependencies defined*

# Attributes

* `node['gitlab_omnibus']['version']` - Specify GitLab version to install. This is ignored if package_url is specified. Defaults to `"7.8.1"`.
* `node['gitlab_omnibus']['install_package_from_repo']` - Set to true if using an internal or hosted Yum/Apt repository
with the GitLab Omnibus package. Enabling this option assumes
the yum/apt repo is already configured on the host. Defaults to `"false"`.
* `node['gitlab_omnibus']['package_url']` - Determine package URL based on specified version
and platform/platform version. Defaults to `""`.
* `node['gitlab_omnibus']['external_url']` - URL where GitLab will be accessible. Defaults to `"https://\#{node['fqdn']}"`.
* `node['gitlab_omnibus']['gitlab_rails']` - Configuration matching `gitlab_rails['config_key']` from `gitlab.rb.template`. Defaults to `"{ ... }"`.
* `node['gitlab_omnibus']['user']` - Configuration matching `user['config_key']` from `gitlab.rb.template`. Defaults to `"{ ... }"`.
* `node['gitlab_omnibus']['unicorn']` - Configuration matching `unicorn['config_key']` from `gitlab.rb.template`. Defaults to `"{ ... }"`.
* `node['gitlab_omnibus']['sidekiq']` - Configuration matching `sidekiq['config_key']` from `gitlab.rb.template`. Defaults to `"{ ... }"`.
* `node['gitlab_omnibus']['gitlab_shell']` - Configuration matching `gitlab_shell['config_key']` from `gitlab.rb.template`. Defaults to `"{ ... }"`.
* `node['gitlab_omnibus']['postgresql']` - Configuration matching `postgresql['config_key']` from `gitlab.rb.template`. Defaults to `"{ ... }"`.
* `node['gitlab_omnibus']['redis']` - Configuration matching `redis['config_key']` from `gitlab.rb.template`. Defaults to `"{ ... }"`.
* `node['gitlab_omnibus']['web_server']` - Configuration matching `web_server['config_key']` from `gitlab.rb.template`. Defaults to `"{ ... }"`.
* `node['gitlab_omnibus']['nginx']` - Configuration matching `nginx['config_key']` from `gitlab.rb.template`. Defaults to `"{ ... }"`.
* `node['gitlab_omnibus']['logging']` - Configuration matching `logging['config_key']` from `gitlab.rb.template`. Defaults to `"{ ... }"`.
* `node['gitlab_omnibus']['logrotate']` - Configuration matching `logrotate['config_key']` from `gitlab.rb.template`. Defaults to `"{ ... }"`.
* `node['gitlab_omnibus']['omnibus_gitconfig']` - Configuration matching `omnibus_gitconfig['config_key']` from `gitlab.rb.template`. Defaults to `"{ ... }"`.
* `node['gitlab_omnibus']['ci_external_url']` - URL where GitLab CI will be accessible. Setting this value enables/configures GitLab CI. Defaults to `"nil"`.
* `node['gitlab_omnibus']['gitlab_ci']` - Configuration matching `gitlab_ci['config_key']` from `gitlab.rb.template`. Defaults to `"{ ... }"`.
* `node['gitlab_omnibus']['ci_unicorn']` - Configuration matching `ci_unicorn['config_key']` from `gitlab.rb.template`. Defaults to `"{ ... }"`.
* `node['gitlab_omnibus']['ci_sidekiq']` - Configuration matching `ci_sidekiq['config_key']` from `gitlab.rb.template`. Defaults to `"{ ... }"`.
* `node['gitlab_omnibus']['ci_redis']` - Configuration matching `ci_redis['config_key']` from `gitlab.rb.template`. Defaults to `"{ ... }"`.
* `node['gitlab_omnibus']['ci_nginx']` - Configuration matching `ci_nginx['config_key']` from `gitlab.rb.template`. Defaults to `"{ ... }"`.

# Recipes

* gitlab_omnibus::default

## Things this cookbook *doesn't* do:

* Manage a firewall
* Install SSH or Postfix
* Manage secrets (database passwords, SSL keys/certs, etc)

### Why not?

This is a library/application cookbook. It's sole purpose is installation
and configuration of GitLab and/or GitLab CI. The goal is to be forward
compatible with future versions of GitLab and avoid assumptions about how
users like to use Chef. Therefore, it does not validate whether configuration
hash values are valid for GitLab Omnibus, it does not require any data bags,
manage secrets, install SSL certificates, or anything else of that nature.
This leaves users free to wrap the cookbook and add those bits that work for
their environment.

Users of this cookbook probably have their own cookbooks/configurations for
these items already. If not, they really should :)


## Roadmap

1. Support GitLab CI Runners


## Testing

### Code Style
To run style tests (Rubocop and Foodcritic):
`rake style`

If you want to run either Rubocop or Foodcritic separately, specify the style
test type (Rubocop = ruby, Foodcritic = chef)
`rake style:chef`
or
`rake style:ruby`

### RSpec tests
Run RSpec unit tests
`rake spec`

### Test Kitchen
Run Test Kitchen tests (these tests take quite a bit of time)
`rake integration:vagrant`


# License and Maintainer

Maintainer:: Drew Blessing (<drew.blessing@mac.com>)

License:: Apache 2.0
