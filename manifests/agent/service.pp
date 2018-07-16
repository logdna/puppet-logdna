# == Class: logdna::agent::service::service_debian
#
#   This class manages LogDNA Agent service on DEB based systems
#
# == Parameters:
# [*service*]
#   LogDNA Agent service status; i.e.,
#   start, stop, or restart.
#

class logdna::agent::service(
    Optional[String] $ensure     = $logdna::params::agent_service
) inherits logdna::params {

    $enable = $ensure ? {
        'running' => true,
        true      => true,
        default   => false
    }

    service { 'logdna-agent':
        ensure     => $ensure,
        enable     => $enable,
        hasrestart => true,
        hasstatus  => true,
        restart    => 'logdna-agent restart',
        status     => 'logdna-agent status'
    }
}
