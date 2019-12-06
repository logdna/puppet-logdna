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
        location => 'https://repo.logdna.com',
        release  => 'stable',
        repos    => 'main',
        key      => {
            id     => '02E0C689A9FCC8110A8FECB9C1BF174AEF506BE8',
            source => 'https://repo.logdna.com/logdna.gpg'
        }
    }

    exec { 'logdna agent apt update':
      command     => '/usr/bin/apt-get update',
      require     => Apt::Source['logdna-agent'],
      subscribe   => Apt::Source['logdna-agent'],
      refreshonly => true,
      timeout     => 600,
      tries       => 5
    }

    -> package { 'logdna-agent':
        ensure   => 'present',
        provider => 'apt',
        require  => Apt::Source['logdna-agent'],
        before   => Service['logdna-agent']
    }
}
