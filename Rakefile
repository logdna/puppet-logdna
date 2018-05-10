require 'rubygems'
require 'puppetlabs_spec_helper/rake_tasks'
require 'puppet-lint'
require 'puppet-syntax/tasks/puppet-syntax'

PuppetLint.configuration.fail_on_warnings
PuppetLint.configuration.send('disable_autoloader_layout')
PuppetLint.configuration.send('disable_80chars')
PuppetSyntax.exclude_paths = [
  'pkg/**/*',
  'vendor/**/*',
  'spec/**/*',
  '.vendor/**/*'
]

task :default => [:spec, :lint, :syntax]
