# OS-specific parameters for apcupsd
class apcupsd::params {

  # Name of package
  $package = $::osfamily ? {
    'RedHat' => 'apcupsd',
    default  => 'apcupsd',
  }

  # Name of service
  $service = $::osfamily ? {
    'RedHat' => 'apcupsd',
    default  => 'apcupsd',
  }
}
