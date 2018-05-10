# == Class: logdna::agent::configure
#
#   This class configures LogDNA Agent
#
# == Parameters:
# [*key*]
#   LogDNA Ingestion Key - LogDNA Agent service will not start
#   unless it is specified
# [*config*]
#   Configuration file alternative to /etc/logdna.conf,
#   which is default
# [*logdir*]
#   Log Directories to be added
# [*logfile*]
#   Log Files to be added
# [*tags*]
#   Tags to be added;
# [*hostname*]
#   Alternative host name to be used
# [*exclude*]
#   Log Files or Directories to be excluded
# [*exclude_regex*]
#   Exclusion Rule for Log Lines
#

class logdna::agent::configure(
    Optional[String] $key            = $logdna::params::conf_key,
    Optional[String] $config         = $logdna::params::conf_config,
    Optional[String] $logdir         = $logdna::params::conf_logdir,
    Optional[String] $logfile        = $logdna::params::conf_logfile,
    Optional[String] $tags           = $logdna::params::conf_tags,
    Optional[String] $hostname       = $logdna::params::conf_hostname,
    Optional[String] $exclude        = $logdna::params::conf_exclude,
    Optional[String] $exclude_regex  = $logdna::params::conf_exclude_regex
) inherits logdna::params {
    if $key {
        exec { 'Setting LogDNA Ingestion Key':
            command => "/usr/bin/logdna-agent -k ${key}"
        }
    }

    if $config {
        exec { 'Using Alternate Config File':
            command => "/usr/bin/logdna-agent -k ${config}"
        }
    }

    if $logdir {
        exec { 'Adding Log Directories':
            command => "/usr/bin/logdna-agent -k ${logdir}"
        }
    }

    if $logfile {
        exec { 'Adding Log Files':
            command => "/usr/bin/logdna-agent -k ${logfile}"
        }
    }

    if $exclude {
        exec { 'Excluding Files from Log Directories':
            command => "/usr/bin/logdna-agent -k ${exclude}"
        }
    }

    if $exclude_regex {
        exec { 'Filtering Out Lines Matching Pattern':
            command => "/usr/bin/logdna-agent -k ${exclude_regex}"
        }
    }

    if $tags {
        exec { 'Setting Tags for This Host':
            command => "/usr/bin/logdna-agent -k ${tags}"
        }
    }

    if $hostname {
        exec { 'Using Alternate Hostname':
            command => "/usr/bin/logdna-agent -k ${hostname}"
        }
    }
}
