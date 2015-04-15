require 'spec_helper'

describe 'git' do
  describe 'is installed' do
    describe file('/usr/share/git-core') do
      it { should be_directory }
    end
  end
  describe 'is running' do
    describe command('git --version') do
       its(:exit_status) { should eq 0 }
    end
  end
end
