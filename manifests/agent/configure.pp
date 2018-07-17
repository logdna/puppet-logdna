# == Class: logdna::agent::configure
#
#   This class configures LogDNA Agent
#
# == Parameters:
# [*key*]
#   LogDNA Ingestion Key - LogDNA Agent service will not start
#   unless it is specified
# [*conf_file*]
#   Configuration file alternative to /etc/logdna.conf,
#   which is default
# [*logdirs*]
#   Log Directories to be added
# [*logfiles*]
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
    Optional[String] $key                  = $logdna::params::conf_key,
    Optional[String] $conf_file            = $logdna::params::conf_file,
    Optional[Array[String]] $logdirs       = $logdna::params::conf_logdir,
    Optional[Array[String]] $logfiles      = $logdna::params::conf_logfile,
    Optional[Array[String]] $tags          = $logdna::params::conf_tags,
    Optional[String] $hostname             = $logdna::params::conf_hostname,
    Optional[Array[String]] $exclude       = $logdna::params::conf_exclude,
    Optional[Array[String]] $exclude_regex = $logdna::params::conf_exclude_regex
) inherits logdna::params {

    $log_objects = concat($logdirs, $logfiles)

    file { $conf_file:
        content => template('logdna/logdna.conf.erb'),
        notify  => Service['logdna-agent']
    }

    if $conf_file != $logdna::params::conf_file {
        exec { "LogDNA Agent: Using Alternate Config File ${conf_file}":
            command => "/usr/bin/logdna-agent -c ${conf_file}"
        }
    }
}
