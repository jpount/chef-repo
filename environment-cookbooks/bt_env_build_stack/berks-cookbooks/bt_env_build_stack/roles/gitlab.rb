name 'gitlab'
description 'Role for a gitlab instance'
run_list(
  "recipe[bt_gitlab_omni::default]", "recipe[bt_ssh::configure_gitlab]"
)
override_attributes(
  'bt_ssh' => {
    'domain' => "ec2-user@bt.base.com"
  },
  'bt_ssh' => {
    'user' => "ec2-user"
  }
)
