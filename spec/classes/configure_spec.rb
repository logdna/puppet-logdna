require 'spec_helper'

describe 'logdna::agent::configure' do
  on_supported_os.each do |os, facts|
    context 'with default values for all parameters' do
      let(:facts) do
        facts
      end
      it {
        should contain_class('logdna::agent::configure')
      }
    end
  end
end
