require 'spec_helper'

describe 'go-server' do
  describe 'is installed' do
    describe file('/var/lib/go-server') do
      it { should be_directory }
    end
  end
  describe 'is running' do
    describe service('go-server') do
      it { should be_running }
    end
  end
  describe 'is listening on the right port' do
    describe port(8153) do
      it { should be_listening }
    end
  end
end
