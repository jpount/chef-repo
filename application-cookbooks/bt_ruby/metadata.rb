name             'bt_ruby'
maintainer       'JP'
maintainer_email 'john.pountain@btfinancialgroup.com'
license          'all_rights'
description      'Installs/Configures bt_ruby'
long_description 'Installs/Configures bt_ruby'
version          '0.1.0'

recipe "bt_ruby::default", "Install rbenv along with specfic versions of Ruby and gems"

depends "rbenv-install-rubies", ">= 0.2.1"
