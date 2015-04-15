name "cloud"
description "the environment for nodes in the aws cloud"
override_attributes(
  :go => {
    :agent => { :auto_register_key => "1234567890abcde" }
  },
  :go => {
    :agent => { :server_host => "go.server.dev.local" }
  },
  :bt_ssh => { :domain => "ec2-user@bt.base.com" },
  :bt_ssh => { :user => "ec2-user" }
)

