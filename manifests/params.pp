# == Class: logdna::params
#
#   This is a container class with default parameters for logdna
#

class logdna::params {
    $conf_key           = undef
    $conf_config        = undef
    $conf_logdir        = undef
    $conf_logfile       = undef
    $conf_tags          = undef
    $conf_hostname      = undef
    $conf_exclude       = undef
    $conf_exclude_regex = undef
    $agent_install      = true
    $agent_configure    = true
    $agent_service      = 'start'
}
