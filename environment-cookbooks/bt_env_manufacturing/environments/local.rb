name "local"
description "the local vagrant/virtualbox environment"
override_attributes(
  :apache2 => { :apache2 => [ "80", "443" ] },
  :runit => { :use_package_from_yum => true }
)
