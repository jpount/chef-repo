name             'bt_artifactory'
maintainer       'The Authors'
maintainer_email 'you@example.com'
license          'all_rights'
description      'Installs/Configures bt_artifactory'
long_description 'Installs/Configures bt_artifactory'
version          '0.1.0'

depends "yum", ">=  3.5.3"
depends "yum-epel", ">=  0.6.0"
depends "bt_java", ">= 0.1.0"
#depends "ark", ">=  0.1.1"
depends "artifactory", ">=  0.3.1"


