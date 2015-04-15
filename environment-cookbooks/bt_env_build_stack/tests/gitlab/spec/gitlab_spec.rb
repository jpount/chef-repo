require 'spec_helper'

describe 'bt_gitlab' do

describe service('nginx') do
#  it { should be_running }
end

describe port(80) do
  it { should be_listening }
end

describe service('redis-server') do
#  it { should be_running }
end

end
