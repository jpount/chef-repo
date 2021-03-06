require 'spec_helper'

describe 'sonarqube' do

  describe 'package is installed' do
    describe file('/etc/init.d/sonarqube') do
      it { should be_file }
    end
  end

  describe 'service is running' do
    describe service('sonarqube') do
      it { should be_running }
    end
  end

  describe 'is listening on the right port' do
    describe port(9000) do
      it { should be_listening }
    end
  end

end

