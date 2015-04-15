name "base_image"
description "A role to configure the base_image"
run_list "recipe[bt_base::default]", "recipe[bt_base::conf]"
override_attributes(
  'bt_ssh' => {
    'domain' => "ec2-user@bt.base.com"
  },
  'bt_ssh' => {
    'user' => "ec2-user"
  }
)

