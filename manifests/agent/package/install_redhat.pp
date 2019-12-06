# == Class: logdna::agent::package::install_redhat
#
#   This class installs LogDNA Agent on RPM based systems
#

class logdna::agent::package::install_redhat(
) inherits logdna::params {

    if $::osfamily != 'RedHat' {
        fail("This OS is not supported: ${::osfamily}")
    }

    yumrepo { 'logdna-agent':
        ensure   => 'present',
        baseurl  => 'https://repo.logdna.com/el6/',
        descr    => 'This is official LogDNA Agent repository',
        enabled  => '1',
        gpgcheck => '0',
    }

    -> exec { 'yum_makecache':
        command => '/usr/bin/yum makecache',
        timeout => 600,
        tries   => 5
    }

    -> package { 'logdna-agent':
        ensure   => 'present',
        provider => 'yum',
        before   => Service['logdna-agent']
    }
}
