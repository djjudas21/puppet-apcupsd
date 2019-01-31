# == Class: apcupsd
#
# Full description of class apcupsd here.
#
# === Parameters
#
# Document parameters here.
#
# [*sample_parameter*]
#   Explanation of what this parameter affects and what it defaults to.
#   e.g. "Specify one or more upstream ntp servers as an array."
#
# === Variables
#
# Here you should define a list of variables that this module would require.
#
# [*sample_variable*]
#   Explanation of how this variable affects the funtion of this class and if
#   it has a default. e.g. "The parameter enc_ntp_servers must be set by the
#   External Node Classifier as a comma separated list of hostnames." (Note,
#   global variables should be avoided in favor of class parameters as
#   of Puppet 2.6.)
#
# === Examples
#
#  class { apcupsd:
#    servers => [ 'pool.ntp.org', 'ntp.local.company.com' ],
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
  Enum['simple','smart','ether','usb'] $upscable              = 'usb',
  Enum['apcsmart','usb','net','snmp','dumb','pcnet'] $upstype = 'usb',
  String $device                                              = '',
  Integer $onbatterydelay                                     = 6,
  Integer $batterylevel                                       = 5,
  Integer $minutes                                            = 3,
  Enum['on','off'] $netserver                                 = 'on',
  String $nisip                                                      = '0.0.0.0',
  Integer $nisport                                                    = 3551,
  String $maildest                                            = $apcupsd::params::maildest,
) inherits apcupsd::params {

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

  # Template for scripts
  file { 'changeme':
    path    => "${apcupsd::scriptdir}changeme",
    content => template('apcupsd/changeme.erb'),
    require => Package['apcupsd'],
  }

  file { 'commfailure':
    path    => "${apcupsd::scriptdir}commfailure",
    content => template('apcupsd/commfailure.erb'),
    require => Package['apcupsd'],
  }

  file { 'commok':
    path    => "${apcupsd::scriptdir}commok",
    content => template('apcupsd/commok.erb'),
    require => Package['apcupsd'],
  }

  file { 'offbattery':
    path    => "${apcupsd::scriptdir}offbattery",
    content => template('apcupsd/offbattery.erb'),
    require => Package['apcupsd'],
  }

  file { 'onbattery':
    path    => "${apcupsd::scriptdir}onbattery",
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

  # Start service
  service { 'apcupsd':
    ensure  => running,
    enable  => true,
    name    => $apcupsd::service,
    require => Package['apcupsd'],
  }
}
