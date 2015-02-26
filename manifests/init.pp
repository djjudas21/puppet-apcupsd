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
  $upsname,
  $upscable = 'usb',
  $upstype = 'usb',
  $device = undef,
  $onbatterydelay = 6,
  $batterylevel = 5,
  $minutes = 3,
  $netserver = true,
) {

  # Install package
  package { 'apcupsd':
    ensure => present,
    name   => $package,
  }

  # Template config file
  file { 'apcupsd.conf':
    name    => $config,
    content => template('apcupsd/apcupsd.conf.erb'),
    require => Package['apcupsd'],
    notify  => Service['apcupsd'],
  }

  # Start service
  service { 'apcupsd':
    ensure  => running,
    require => Package['apcupsd'],
  }
}
