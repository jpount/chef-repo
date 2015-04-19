name             'bt_go'
maintainer       'JP'
maintainer_email 'john.pountain@btfinancialgroup.com'
license          'all_rights'
description      'Installs/Configures go_agent'
long_description 'Installs/Configures go_agent'
version          '0.1.0'

supports "ubuntu", ">= 12.04"
supports "centos"
supports "windows"

recipe "bt_go::server", "Installs and configures a Go server"
recipe "bt_go::agent", "Installs and configures a Go agent"
recipe "bt_go::default", "Installs and configures a Go server and agent on the same node, for windows just agent"
recipe "bt_go::agent_windows", "Installs and configures Windows Go agent"
recipe "bt_go::agent_linux", "Install and configures Linux Go agent"

depends "apt", ">= 1.9.2"
depends "bt_java", ">= 0.1.0"
depends "yum", ">= 3.0.0"
depends "windows", ">= 1.2.6"
