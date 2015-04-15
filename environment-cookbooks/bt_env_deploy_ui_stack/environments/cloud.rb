name "cloud"
description "the environment for nodes in the aws cloud"
override_attributes(
  :tomcat => { :base_version => "7" }
)
