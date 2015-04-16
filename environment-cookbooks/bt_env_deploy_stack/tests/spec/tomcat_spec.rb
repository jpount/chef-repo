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

#describe "Tomcat Daemon" do
#  it "is listening on port 8080" do
#    expect(port(8080)).to be_listening
#  end
#  it "has a running service of tomcat" do
#    expect(service("tomcat")).to be_running
#  end
#end

describe group("tomcat") do
  it { should exist }
end

describe user("tomcat") do
  it { should exist }
  it { should belong_to_group "tomcat" }
end

describe file("/var/lib/tomcat") do
  it { should be_directory }
end

describe file("/etc/tomcat/conf/server.xml") do
#  it { should be_owned_by "tomcat" }
#  it { should be_writable.by_user("tomcat") }
#  it { should be_readable.by_user("tomcat") }
end

