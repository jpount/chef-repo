name "cloud"
description "the environment for nodes in the aws cloud"
override_attributes(
  :bt_ssh => { :domain => "ec2-user@bt.base.com" },
  :bt_ssh => { :user => "ec2-user" }
)
