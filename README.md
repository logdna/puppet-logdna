# Deploy LogDNA with Puppet

[![CircleCI](https://circleci.com/gh/logdna/puppet-logdna/tree/master.svg?style=svg&circle-token=d32c6c3959769a2347536d45c1204b2cb022c32c)](https://circleci.com/gh/logdna/puppet-logdna/tree/master)

#### Table of Contents

1. [Description](#description)
2. [Setup - The basics of getting started with LogDNA Module](#setup)
3. [Parameters - Parameters of this module](#parameters)
4. [Platforms - The list of platforms tested](#platforms)
5. [Usage - Configuration options and additional functionality](#usage)

## Description

Puppet module to install and configure LogDNA Agent

## Setup

To use this module, add this declaration to your Puppetfile:
```
mod 'logdna-logdna'
```
To manually install this module with puppet module tool:
```
puppet module install logdna-logdna
```

## Parameters

Parameters have default values set in `manifests/params.pp`.

### Task-specific Attributes

* `agent_install`: Whether to install or not. Default is `true`
* `agent_configure`: Whether to configure or not. Default is `true`
* `agent_service`: How to manage LogDNA Agent Service. Default is `start`. The possible values are:
  * `start`: in order to start
  * `stop`: in order to stop
  * `restart`: in order to restart

### Configuration Attributes

* `conf_key`: LogDNA API Key - LogDNA Agent won't start unless `conf_key` is set
* `conf_file`: File Path for the LogDNA Agent configuration (defaults to `/etc/logdna.conf`)
* `conf_logdir`: Log Directories to be added
* `conf_logfile`: Log Files to be added
* `conf_exclude`: Log Files or Directories to be excluded
* `conf_exclude_regex`: Exclusion Rule for Log Lines
* `conf_hostname`: Alternative host name to be used
* `conf_tags`: Tags to be added

## Platforms Tested

* CentOS 6
* CentOS 7
* Ubuntu 14.04 - Trusty
* Ubuntu 16.04 - Xenial

## Usage

There are 2 ways:
* Update parameters in `logdna::params` and `include logdna`, or
* `class { 'logdna': <param> => <value> }`

## Contributing

Contributions are always welcome. See the [contributing guide](https://github.com/logdna/puppet-logdna/blob/master/CONTRIBUTING.md) to learn how you can help.

## License and Authors

* Author: [Samir Musali](https://github.com/ldsamir), LogDNA
* License: MIT
