# == Class: logdna::agent::package::install_debian
#
#   This class installs LogDNA Agent on DEB based systems
#

class logdna::agent::package::install_debian(
) inherits logdna::params {

    if $::osfamily != 'Debian' {
        fail("This OS is not supported: ${::osfamily}")
    }

    apt::source { 'logdna-agent':
        comment  => 'This is official LogDNA Agent repository',
        location => 'http://repo.logdna.com',
        release  => 'stable',
        repos    => 'main',
        key      => {
            id     => '02E0C689A9FCC8110A8FECB9C1BF174AEF506BE8',
            source => 'http://repo.logdna.com/logdna.gpg'
        }
    }

    -> package { 'logdna-agent':
        ensure   => 'present',
        provider => 'apt',
        require  => Apt::Source['logdna-agent']
    }
}
