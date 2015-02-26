# OS-specific parameters for apcupsd
class apcupsd::params {

  # Name of package
  $package = $::osfamily ? {
    'RedHat' => 'apcupsd',
    'Debian' => 'apcupsd',
    default  => 'apcupsd',
  }

  # Name of service
  $service = $::osfamily ? {
    'RedHat' => 'apcupsd',
    'Debian' => 'apcupsd',
    default  => 'apcupsd',
  }

  # Config file
  $config = $::osfamily ? {
    'RedHat' => '/etc/apcupsd/apcupsd.conf',
    'Debian' => '/etc/apcupsd/apcupsd.conf',
    default  => '/etc/apcupsd/apcupsd.conf',
  }

}
