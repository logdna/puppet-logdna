require 'spec_helper'

describe 'logdna::agent::package::install_debian' do
  on_supported_os.each do |os, facts|
    context 'with default values for all parameters' do
      let(:facts) do
        facts
      end
      case facts[:osfamily]
      when 'Debian'
        it {
          should contain_class('logdna::agent::package::install_debian')
        }
      else
        it {
          is_expected.not_to compile.with_all_deps.and_raise_error(Puppet::ParseError)
        }
      end
    end
  end
end
