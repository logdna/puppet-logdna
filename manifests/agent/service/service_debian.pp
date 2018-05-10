# == Class: logdna::agent::service::service_debian
#
#   This class manages LogDNA Agent service on DEB based systems
#
# == Parameters:
# [*service*]
#   LogDNA Agent service status; i.e.,
#   start, stop, or restart.
#

class logdna::agent::service::service_debian(
    Optional[String] $service     = $logdna::params::agent_service
) inherits logdna::params {

    if $::osfamily != 'Debian' {
        fail("This OS is not supported: ${::osfamily}")
    }

    exec { 'Activating LogDNA Agent Service':
        command => '/usr/sbin/update-rc.d logdna-agent defaults'
    }

    if $service == 'stop' {
        service { 'logdna-agent':
            ensure     => stopped,
            enable     => true,
            hasrestart => true,
            hasstatus  => true,
            restart    => 'logdna-agent restart',
            status     => 'logdna-agent status'
        }
    } else {
        service { 'logdna-agent':
            ensure     => running,
            enable     => true,
            hasrestart => true,
            hasstatus  => true,
            restart    => 'logdna-agent restart',
            status     => 'logdna-agent status'
        }
    }
}
