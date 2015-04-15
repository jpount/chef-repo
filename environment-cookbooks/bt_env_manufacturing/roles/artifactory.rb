name 'artifactory'
description 'Role for an Artifactory instance'
run_list(
  "recipe[yum-epel::default]", "recipe[bt_artifactory::default]"
)
override_attributes(
  'runit' => {
    'use_package_from_yum' => false
  },
  'artifactory' => {
    'install_java' => false
  }
)

