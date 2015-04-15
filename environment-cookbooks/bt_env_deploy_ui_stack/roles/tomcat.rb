name "tomcat"
description "A role to configure tomcat"
run_list "recipe[bt_tomcat::default]"
override_attributes(
  'tomcat' => {
    'base_version' => "7"
  }
)

