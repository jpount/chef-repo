name 'go_server'
description 'Role for a go server instance'
run_list(
  'recipe[bt_go::server]'
)
