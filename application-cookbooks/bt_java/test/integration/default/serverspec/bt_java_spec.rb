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
      its(:stdout) { should match(/java version \"1.7/) }
    end
  end
end
