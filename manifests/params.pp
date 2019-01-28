# OS-specific parameters for apcupsd
class apcupsd::params {

  # Name of package
  $package = $facts['osfamily'] ? {
    'RedHat' => 'apcupsd',
    'Debian' => 'apcupsd',
    default  => 'apcupsd',
  }

  # Name of service
  $service = $facts['osfamily'] ? {
    'RedHat' => 'apcupsd',
    'Debian' => 'apcupsd',
    default  => 'apcupsd',
  }

  # Config file
  $config = $facts['osfamily'] ? {
    'RedHat' => '/etc/apcupsd/apcupsd.conf',
    'Debian' => '/etc/apcupsd/apcupsd.conf',
    default  => '/etc/apcupsd/apcupsd.conf',
  }

  # Defaults file
  $defaults = $facts['osfamily'] ? {
    'Debian' => '/etc/default/apcupsd',
    default  => undef,
  }

  $apcaccess_executable = $facts['osfamily'] ? {
    'Debian' => '/sbin/apcaccess',
    'RedHat' => '/usr/sbin/apcaccess',
    default  => '/usr/sbin/apcaccess',
  }

  # Script directory
  $scriptdir = $facts['osfamily'] ? {
    'RedHat' => '/etc/apcupsd/',
    'Debian' => '/etc/apcupsd/',
    default  => '/etc/apcupsd/',
  }

  $maildest = 'root'

}
