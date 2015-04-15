name 'apache2'
description 'Role for Apache web server'
run_list(
  'recipe[bt_apache2::default]'
)

