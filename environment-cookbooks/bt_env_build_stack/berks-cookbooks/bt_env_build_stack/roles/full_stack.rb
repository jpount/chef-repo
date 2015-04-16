name "full_stack"
description "A role to configure a full build stack"
run_list "recipe[bt_git::default], recipe[bt_go::server], recipe[bt_go::agent]"

