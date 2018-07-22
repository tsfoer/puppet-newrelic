# == Class: newrelic::infra
#
# Installs and starts the New Relic Infrastrucure Agent, and replaces the
# deprecated server class.
#
# === Parameters
#
# [*license_key*]
#   NewRelic API license key (String)
#
# [*manage_repo*]
#   Whether to install the NewRelic OS repositories
#   Default: Varies depending on OS (Boolean)
#
# [*service_ensure*]
#   State of the $service_name (newrelic-infra) service
#   Default: running (String)
#
# [*service_name*]
#   Name of the newrelic infra service
#   Default: newrelic-infra (String)
#
# [*service_enable*]
#   Whether to enable the service at boot
#   Default: true (Boolean)
#
# === Authors
#
# Russell Whelan <russell.whelan@claranet.uk>
# Craig Watson <craig.watson@claranet.uk>
#
# === Copyright
#
# Copyright 2017 Claranet
#
class newrelic::infra (
  String $license_key,
  Boolean $manage_repo    = $::newrelic::params::manage_repo,
  String  $service_ensure = 'running',
  String  $service_name   = 'newrelic-infra',
  Boolean $service_enable = true
) inherits newrelic::params {

  if $facts['os']['family'] == 'Windows' {
    fail('newrelic::infra is not supported yet on Windows.')
  }

  if $::newrelic::infra::manage_repo == true {
    contain ::newrelic::repo::infra
    File['/etc/newrelic-infra.yml'] {
      require => $::newrelic::repo::infra::require,
    }
  }

  file { '/etc/newrelic-infra.yml':
    ensure  => file,
    content => "license_key: ${license_key}\n",
    notify  => Service['newrelic-infra'],
  }

  package { 'newrelic-infra':
    ensure  => present,
    require => File['/etc/newrelic-infra.yml'],
  }

  service { $service_name:
    ensure  => $service_ensure,
    name    => $service_name,
    enable  => $service_enable,
    require => Package['newrelic-infra']
  }
}
