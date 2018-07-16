# == Class: logdna::params
#
#   This is a container class with default parameters for logdna
#

class logdna::params {
    $conf_key           = undef
    $conf_file          = '/etc/logdna.conf'
    $conf_logdir        = []
    $conf_logfile       = []
    $conf_tags          = []
    $conf_hostname      = undef
    $conf_exclude       = []
    $conf_exclude_regex = []
    $agent_install      = true
    $agent_configure    = true
    $agent_service      = 'running'
}
