name 'git'
description 'Role for a git instance'
run_list(
  "recipe[bt_git::default]", "recipe[bt_ssh::configure_git]"
)
override_attributes(
  'bt_ssh' => {
    'domain' => "ec2-user@bt.base.com"
  },
  'bt_ssh' => {
    'user' => "ec2-user"
  }
)

