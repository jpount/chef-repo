name "local"
description "the local vagrant/virtualbox environment"
cookbook_versions({
    "bt_java" => "= 0.1.0",
    "bt_tomcat" => "= 0.1.0"
})
override_attributes(
  :tomcat => { :base_version => "6" }
)
