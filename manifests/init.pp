# == Class: logdna
#
#   This class installs and configures LogDNA Agent
#
# == Parameters:
# [*conf_key*]
#   LogDNA Ingestion Key - LogDNA Agent service will not start
#   unless it is specified
# [*conf_config*]
#   Configuration file alternative to /etc/logdna.conf,
#   which is default
# [*conf_logdir*]
#   Log Directories to be added
# [*conf_logfile*]
#   Log Files to be added
# [*conf_tags*]
#   Tags to be added
# [*conf_hostname*]
#   Alternative host name to be used
# [*conf_exclude*]
#   Log Files or Directories to be excluded
# [*conf_exclude_regex*]
#   Exclusion Rule for Log Lines
# [*agent_install*]
#   Whether or not to install the agent
# [*agent_configure*]
#   Whether or not to configure the agent
# [*agent_service*]
#   LogDNA Agent service status; i.e.,
#   start, stop, or restart
#

class logdna (
    Optional[String] $conf_key            = $logdna::params::conf_key,
    Optional[String] $conf_config         = $logdna::params::conf_config,
    Optional[String] $conf_logdir         = $logdna::params::conf_logdir,
    Optional[String] $conf_logfile        = $logdna::params::conf_logfile,
    Optional[String] $conf_tags           = $logdna::params::conf_tags,
    Optional[String] $conf_hostname       = $logdna::params::conf_hostname,
    Optional[String] $conf_exclude        = $logdna::params::conf_exclude,
    Optional[String] $conf_exclude_regex  = $logdna::params::conf_exclude_regex,
    Boolean $agent_install                = $logdna::params::agent_install,
    Boolean $agent_configure              = $logdna::params::agent_configure,
    Optional[String] $agent_service       = $logdna::params::agent_service
) inherits logdna::params {

    if $agent_install {
        case $::osfamily {
            'RedHat': {
                include 'logdna::agent::package::install_redhat'
            }
            'Debian': {
                include 'logdna::agent::package::install_debian'
            }
            default: {
                fail("This OS is not supported: ${::osfamily}")
            }
        }
    }

    if $agent_configure {
        include logdna::agent::configure
    }

    if $agent_service == 'stop' or $conf_key {
        case $::osfamily {
            'RedHat': {
                include 'logdna::agent::service::service_redhat'
            }
            'Debian': {
                include 'logdna::agent::service::service_debian'
            }
            default: {
                fail("This OS is not supported: ${::osfamily}")
            }
        }
    }

}
