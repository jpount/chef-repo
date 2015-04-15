require 'spec_helper'

# confirm the java install
describe 'java' do
  describe 'is installed' do
    describe command('java -version') do
      its(:exit_status) { should eq 0 }
    end
  end
  describe 'is version 7' do
    describe command('java -version') do
      its(:stdout) { should match /java version \"1.7/ }
    end
  end
end

# ssh was installed
describe 'ssh file' do
  describe 'is installed' do
    describe file('/home/ec2-user/.ssh/id_rsa.pub') do
      it { should be_file }
    end
  end
end

# git was installed
describe 'git' do
  describe 'is installed' do
    describe command('git --version') do
      its(:exit_status) { should eq 0 }
    end
  end
end

# bootstrap file was installed
describe 'bootstrap file' do
  describe 'is installed' do
    describe file('/usr/local/bin/bootstrap_script/bootstrap.sh') do
      it { should be_file }
    end
  end
  describe 'is executable' do
    describe file('/usr/local/bin/bootstrap_script/bootstrap.sh') do
      it { should be_executable }
    end
  end
end


