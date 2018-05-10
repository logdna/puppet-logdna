# == Class: logdna::agent::service::service_redhat
#
#   This class manages LogDNA Agent service on RPM based systems
#
# == Parameters:
# [*service*]
#   LogDNA Agent service status; i.e.,
#   start, stop, or restart.
#

class logdna::agent::service::service_redhat(
    Optional[String] $service     = $logdna::params::agent_service
) inherits logdna::params {

    if $::osfamily != 'RedHat' {
        fail("This OS is not supported: ${::osfamily}")
    }

    exec { 'Activating LogDNA Agent Service':
        path    => '/bin:/sbin',
        command => 'chkconfig logdna-agent on'
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
