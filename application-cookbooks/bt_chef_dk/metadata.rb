name             'bt_chef_dk'
maintainer       'JP'
maintainer_email 'john.pountain@btfinancialgroup.com'
license          'all_rights'
description      'Installs/Configures bt_chef_dk'
long_description 'Installs/Configures bt_chef_dk'
version          '0.1.0'

recipe "bt_chef_dk::default", "Install chef-dk and other things needed for testing chef related stuff"

depends "chef-dk", ">= 3.0.0"

