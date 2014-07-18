# == Class: curl
#
# This puppet module install curl package
#
# === Parameters
#   [*ensure*]
#     Ensure if present or absent.
#     Default: present
#
#   [*autoupgrade*]
#     Upgrade package automatically, if there is a newer version.
#     Default: false
#
#   [*package*]
#     Name of the package.
#     Only set this, if your platform is not supported or you know,
#     what you're doing.
#     Default: auto-set, platform specific
#
#   [*package_provider*]
#     Name of the package provider.
#     Default: auto-set, platform specific
#
# === Examples
#
#  class { curl:
#  }
#
#  class { curl:
#   autoupgrade => true,
#  }
#
class curl(
  $ensure              = 'present',
  $autoupgrade         = false,
  $package             = $curl::params::package,
  $package_provider    = $curl::params::package_provider,
) inherits curl::params {

    case $ensure {
    /(present)/: {
      if $autoupgrade == true {
        $package_ensure = 'latest'
      } else {
        $package_ensure = 'present'
      }
    }
    /(absent)/: {
      $package_ensure = 'absent'
    }
    default: {
      fail('ensure parameter must be present or absent')
    }
  }

  package { $package:
    ensure    => $package_ensure,
    provider  => $package_provider,
  }
}