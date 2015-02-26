require 'spec_helper'
describe 'apcupsd' do

  context 'with defaults for all parameters' do
    it { should contain_class('apcupsd') }
  end
end
