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
        baseurl  => 'http://repo.logdna.com/el6/',
        descr    => 'This is official LogDNA Agent repository',
        enabled  => '1',
        gpgcheck => '0',
    }

    -> exec { 'yum_update':
        command => '/usr/bin/yum update -y'
    }

    -> package { 'logdna-agent':
        ensure   => 'present',
        provider => 'yum',
        before   => Service['logdna-agent']
    }
}
