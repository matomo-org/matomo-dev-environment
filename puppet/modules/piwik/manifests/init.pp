# = Class: piwik
# 
# This class installs all required packages and services in order to run Piwik. 
# It'll do a checkout of the Piwik repository as well. You only have to setup
# Apache and/or NGINX afterwards.
# 
# == Parameters: 
#
# $directory::         The piwik repository will be checked out into this directory.
# $version::           The Piwik version. Defaults to 'trunk'. 
#                      Valid values: For example 'tags/1.8.3' or 'branch/whatever'. 
# $db_user::           If defined, it creates a MySQL user with this username.
# $db_password::       The MySQL user's password.
# $db_root_password::  A password for the MySQL root user.
# $log_analytics::     Whether log analytics will be used. Defaults to true. 
#                      Valid values: true or false
# 
# == Requires: 
# 
# See README
# 
# == Sample Usage:
#
#  class {'piwik': }
#
#  class {'piwik':
#    db_root_password => '123456',
#    repository => 'git',
#  }
#
class piwik(
  $directory   = $piwik::params::docroot,
  $version     = $piwik::params::piwik_version,
  $db_user     = $piwik::params::db_user,
  $db_password = $piwik::params::db_password,
  $db_root_password = $piwik::params::db_password,
  $log_analytics    = true,
) inherits piwik::params {

  # include piwik::user

  include piwik::base

  # mysql / db
  class { 'piwik::db':
    username      => $db_user,
    password      => $db_password,
    root_password => $db_root_password,
    require       => Class['piwik::base'],
  }

  class { 'piwik::php':
     require => Class['piwik::db'],
  }

  if $log_analytics == true {
    include piwik::loganalytics
  }

  # repo checkout
  piwik::repo { 'piwik_repo_setup':
    directory => $directory,
    version   => $version,
    require   => Class['piwik::base'],
  }

  exec { 'install_composer_manual':
    command => 'curl -s https://getcomposer.org/installer | sudo php -- --install-dir="/bin"',
    require => [ Package['curl'], Class['piwik::php'] ],
    unless  => 'which composer.phar',
  }

  # do composer.phar install

}
