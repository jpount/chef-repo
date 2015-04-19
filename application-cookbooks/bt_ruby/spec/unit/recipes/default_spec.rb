#
# Cookbook Name:: bt_ruby
# Spec:: default
#
# Copyright (c) 2015 JP, All Rights Reserved.

require 'spec_helper'

describe 'bt_ruby::default' do

  before do
    Fauxhai.mock(platform: 'centos', version: '6.5')
  end

  context 'When default recipe is run' do

    cached(:chef_run) do
      ChefSpec::ServerRunner.new.converge(described_recipe)
    end

    it 'converges successfully' do
      chef_run 
    end

    it 'should have created user rbenv' do
      expect(chef_run).to create_user('rbenv')
    end

    it 'should have created group rbenv' do
      expect(chef_run).to create_group('rbenv')
    end

    it 'should have created rbenv directory' do
      expect(chef_run).to create_directory('/opt/rbenv').with(
        user:   'rbenv',
        group:  'rbenv'
      )
    end

    it 'should have created user vagrant' do
      expect(chef_run).to create_user('vagrant')
    end

    it 'should have created rbenv shims directory' do
      expect(chef_run).to create_directory('/opt/rbenv/shims')
    end

    it 'should have installed ruby' do
      expect(chef_run).to create_directory('/opt/rbenv/versions/2.1.4')
    end

    it 'should have installed libxslt-devel package' do
      expect(chef_run).to install_package('libxslt-devel')
    end

    it 'should have installed libxml2-devel package' do
      expect(chef_run).to install_package('libxml2-devel')
    end

    it 'should have install pry gem' do
      expect(chef_run).to install_package('pry')
    end

    it 'should have installed bundler gem' do
      expect(chef_run).to install_gem_package('bundler')
    end

    it 'should have installed requested gems' do
      expect(chef_run).to install_gem_package('bundler')
      expect(chef_run).to install_gem_package('pry')
      expect(chef_run).to install_gem_package('rbenv-rehash')
      expect(chef_run).to install_gem_package('nokogiri')
      expect(chef_run).to install_gem_package('chefspec')
      expect(chef_run).to install_gem_package('serverspec')
      expect(chef_run).to install_gem_package('fauxhai')
      expect(chef_run).to install_gem_package('foodcritic')
      expect(chef_run).to install_gem_package('rubocop')
      expect(chef_run).to install_gem_package('rspec')
    end

  end
end

describe package('pry') do
  let(:path) { '/opt/rbenv/shims' }
  it { should be_installed.by('gem') }
end
