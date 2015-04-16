require 'spec_helper'

describe 'go-agent' do
  describe 'is installed' do
    describe file('/var/lib/go-agent') do
      it { should be_directory }
    end
  end
  describe 'is running' do
    describe service('go-agent') do
      it { should be_running }
    end
  end
end
