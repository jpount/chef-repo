require 'spec_helper'

# confirm the install
describe 'artifactory' do

  describe 'package is installed' do
    describe file('/var/lib/artifactory') do
      it { should be_directory }
    end
  end

  describe 'service is running' do
    describe service('artifactory') do
      it { should be_running }
    end
  end

  describe 'is listening on the right port' do
    describe port(8081) do
      it { should be_listening }
    end
  end

end

