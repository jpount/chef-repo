#
# Cookbook Name:: bt_java
# Spec:: default
#
# Copyright (c) 2015 JP, All Rights Reserved.

require 'spec_helper'

describe 'bt_java::default' do
  before do
    Fauxhai.mock(platform: 'centos', version: '6.5')
  end

  context 'When all attributes are default, on an unspecified platform' do
    cached(:chef_run) do
      ChefSpec::ServerRunner.new.converge(described_recipe)
    end

    it 'converges successfully' do
      chef_run
    end

    it 'should include java cookbook default recipe' do
      expect(chef_run).to include_recipe('java::default')
    end

    it 'should have the correct jdk attributes' do
      expect(chef_run.node['java']['install_flavor']).to eq('openjdk')
      expect(chef_run.node['java']['jdk_version']).to eq('7')
    end

    it 'should install java (openjdk-7)' do
      expect(chef_run).to install_package('openjdk-7-jdk')
    end
  end
end
