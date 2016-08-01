require 'spec_helper'
describe 'timesyncd' do
  context 'with default values for all parameters' do
    it { should contain_class('timesyncd') }
  end
end
