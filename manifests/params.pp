# == Class curl::params
#
# This class is meant to be called from curl
# It sets variables according to platform
#
class curl::params {
  case $::osfamily {
    'Amazon', 'Debian', 'RedHat', 'Suse': {
      $package_name = 'curl'
    }
    solaris: {
      case $::kernelrelease {
        '5.11': {
          $package = 'curl'
        }
        '5.10': {
          $package = 'CSWcurl'
          $package_provider = 'pkgutil'
        }
      }
    }
    default: {
      warning("Module 'curl' is not currently supported on ${::operatingsystem}")
    }
  }
}
