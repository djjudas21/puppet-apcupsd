# == Class: apcupsd
#
# Configure apcupsd software for APC UPS devices
#
# === Parameters
#
# Document parameters here.
#
# === Examples
#
#  class { apcupsd:
#    upsname => 'BU1500',
#  }
#
# === Authors
#
# Author Name <author@domain.com>
#
# === Copyright
#
# Copyright 2015 Your name here, unless otherwise noted.
#
class apcupsd (
  String[1,8] $upsname,
  String $package,
  String $config,
  String $scriptdir,
  String $apcaccess_executable,
  Optional[String] $defaults,
  Enum['simple','smart','ether','usb'] $upscable,
  Enum['apcsmart','usb','net','snmp','dumb','pcnet'] $upstype,
  String $device,
  Integer $onbatterydelay,
  Integer $batterylevel,
  Integer $minutes,
  Enum['on','off'] $netserver,
  String $nisip,
  Integer $nisport,
  String $maildest,
  String $service,
  Enum['stopped','false','running','true'] $service_ensure,
  Enum['true','false','manual','mask'] $service_enable,
) {

  # Install package
  package { 'apcupsd':
    ensure => present,
    name   => $apcupsd::package,
  }

  # Template config file
  file { 'apcupsd.conf':
    path    => $apcupsd::config,
    content => template('apcupsd/apcupsd.conf.erb'),
    require => Package['apcupsd'],
    notify  => Service['apcupsd'],
  }

  # Templates for scripts
  file { 'changeme':
    path    => "${apcupsd::scriptdir}/changeme",
    content => template('apcupsd/changeme.erb'),
    require => Package['apcupsd'],
  }

  file { 'commfailure':
    path    => "${apcupsd::scriptdir}/commfailure",
    content => template('apcupsd/commfailure.erb'),
    require => Package['apcupsd'],
  }

  file { 'commok':
    path    => "${apcupsd::scriptdir}/commok",
    content => template('apcupsd/commok.erb'),
    require => Package['apcupsd'],
  }

  file { 'offbattery':
    path    => "${apcupsd::scriptdir}/offbattery",
    content => template('apcupsd/offbattery.erb'),
    require => Package['apcupsd'],
  }

  file { 'onbattery':
    path    => "${apcupsd::scriptdir}/onbattery",
    content => template('apcupsd/onbattery.erb'),
    require => Package['apcupsd'],
  }

  if $apcupsd::defaults {
    file { 'default-apcupsd':
      path    => $apcupsd::defaults,
      content => template('apcupsd/default-apcupsd.erb'),
      require => Package['apcupsd'],
      notify  => Service['apcupsd'],
    }
  }

  # Service
  service { 'apcupsd':
    ensure  => $apcupsd::service_ensure,
    enable  => $apcupsd::service_enable,
    name    => $apcupsd::service,
    require => Package['apcupsd'],
  }
}
