name 'go_agent'
description 'Role for a go agent instance on spin up'
run_list(
  'recipe[bt_go::agent_linux_bootstrap_reconfigure]'
)
