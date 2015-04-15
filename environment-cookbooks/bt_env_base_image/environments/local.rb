name "local"
description "the local vagrant/virtualbox environment"
override_attributes(
  :bt_ssh => { :domain => "ec2-user@bt.base.com" },
  :bt_ssh => { :user => "ec2-user" }
)

