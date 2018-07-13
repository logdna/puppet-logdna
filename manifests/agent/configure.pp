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
    Optional[String] $key             = $logdna::params::conf_key,
    Optional[String] $config          = $logdna::params::conf_config,
    Optional[Array[String]] $logdirs  = $logdna::params::conf_logdir,
    Optional[Array[String]] $logfiles = $logdna::params::conf_logfile,
    Optional[Array[String]] $tags     = $logdna::params::conf_tags,
    Optional[String] $hostname        = $logdna::params::conf_hostname,
    Optional[Array[String]] $exclude  = $logdna::params::conf_exclude,
    Optional[String] $exclude_regex   = $logdna::params::conf_exclude_regex
) inherits logdna::params {

    if $key {
        exec { 'Setting LogDNA Ingestion Key':
            command => "/usr/bin/logdna-agent -k ${key}"
        }
    }

    if $config {
        exec { 'Using Alternate Config File':
            command => "/usr/bin/logdna-agent -c ${config}"
        }
    }

    if $logdirs and !empty($logdirs) {
        $logdirs.each |String $logdir| {
            exec { "LogDNA - Adding Log Directory - ${logdir}":
                command => "/usr/bin/logdna-agent -d ${logdir}"
            }
        }
    }

    if $logfiles and !empty($logfiles) {
        $logfiles.each |String $logfile| {
            exec { "LogDNA - Adding Log File - ${logfile}":
                command => "/usr/bin/logdna-agent -f ${logfile}"
            }
        }
    }


    if $exclude_regex and !empty($exclude_regex) {
        $exclude_regex.each |String $exclude_pattern| {
            exec { "LogDNA - Adding Log Exclusion - ${exclude_path}":
                command => "/usr/bin/logdna-agent -r ${exclude_pattern}"
            }
        }
    }

    if $exclude and !empty($exclude) {
        $exclude.each |String $exclude_path| {
            exec { "LogDNA - Adding Log Exclusion - ${exclude_path}":
                command => "/usr/bin/logdna-agent -e ${exclude_path}"
            }
        }
    }

    if $tags and !empty($tags) {
        $flat_tags = join($tags, ',')
        exec { 'Setting Tags for This Host':
            command => "/usr/bin/logdna-agent -t ${flat_tags}"
        }
    }

    if $hostname {
        exec { 'Using Alternate Hostname':
            command => "/usr/bin/logdna-agent -n ${hostname}"
        }
    }
}
