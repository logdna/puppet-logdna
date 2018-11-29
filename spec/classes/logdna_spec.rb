require "spec_helper"

describe "logdna" do
  context "unsupported operating system" do
    describe "logdna class without any parameters on Solaris/Nexenta" do
      let(:facts) do
        {
          osfamily:         "Solaris",
          operatingsystem:  "Nexenta"
        }
      end

      it do
        is_expected.not_to compile.with_all_deps.and_raise_error(Puppet::ParseError)
      end
    end
  end

  # Test all supported OSes
  context "all supported operating systems" do
    on_supported_os.each do |os, facts|
      describe "logdna class common actions on #{os}" do
        let(:facts) do
          facts
        end

        it { should compile.with_all_deps }

        it { should contain_class("logdna") }

        describe "logdna imports the default params" do
          it { should contain_class("logdna::params") }
        end

        it { should contain_file("/etc/logdna.conf") }

        it { should contain_class("logdna::agent::service") }

        it { should contain_class("logdna::agent::configure") }

        case facts[:osfamily]
        when 'Debian'
          it { should contain_class("logdna::agent::package::install_debian") }
        when 'RedHat'
          it { should contain_class("logdna::agent::package::install_redhat") }
        else
          it {
            is_expected.not_to compile.with_all_deps.and_raise_error(Puppet::ParseError)
          }
        end
      end
    end
  end
end