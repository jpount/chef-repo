# README

This is an environment/infrastructure repository using the [vagrant-toplevel-cookbooks](https://github.com/tknerr/vagrant-toplevel-cookbooks) plugin to resolve the top-level cookbook dependencies for each of the `Vagrantfile`'s VMs in isolation. 

The aim is to get the whole infrastructure up and running with a single `vagrant up`, with all the cookbook dependency resolution happening under the hood.

# USAGE

First, make sure you have the required Vagrant plugins installed:

	vagrant plugin install vagrant-omnibus
	vagrant plugin install vagrant-toplevel-cookbooks

Now you can bring up and provision the VMs in the `Vagrantfile` with a single command:

	vagrant up app_v1
	vagrant up app_v2

# Packer

To create the image you need to navigate to the Packer directory and then run ./ami_factory.sh .packer.json 
