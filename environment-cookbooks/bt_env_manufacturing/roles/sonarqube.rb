name 'sonarqube'
description 'Role for a Sonarqube instance'
run_list(
  'recipe[bt_sonarqube::default]'
)
