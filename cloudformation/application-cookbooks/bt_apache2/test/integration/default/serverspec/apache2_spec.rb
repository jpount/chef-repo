require 'spec_helper'

# confirm the install
describe 'apache2' do
  describe 'is listening on the right port' do
    describe port(80) do
      it { should be_listening }
    end
  end
end
