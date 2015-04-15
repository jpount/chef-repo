name "cloud"
description "the environment for nodes in the aws cloud"
override_attributes(
  :apache2 => { :apache2 => [ "80", "443" ] },
  :runit => { :use_package_from_yum => false },
  :artifactory => { :install_java => false }
)
