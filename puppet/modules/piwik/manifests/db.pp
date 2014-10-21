# = Class: piwik::db
# 
# This class installs several database packages which are required by Piwik.
# It installs a MySQL server, starts the MySQL service and installs some 
# useful tools like Percona Toolkit and MySQLTuner.
# 
# == Parameters: 
# 
# $root_password::  A password for the MySQL root user
# $username::       If defined, a MySQL user with this name will be created 
# $password::       The MySQL user's password
# 
# == Requires: 
# 
# == Sample Usage:
#
#  include piwik::db
#
#  class {'piwik::db':
#    root_password => '123456',
#    username => 'piwik',
#    password => 'piwik'
#  }
#
class piwik::db(
  $username      = $piwik::params::db_user,
  $password      = $piwik::params::db_password,
  $root_password = $piwik::params::db_password,
) {

  if $ipaddress_eth1 {
      $ipaddress = $ipaddress_eth1
  } elsif $ipaddress_eth0 {
      $ipaddress = $ipaddress_eth0
  } else {
      $ipaddress = "127.0.0.1"
  }

  $override_options = {
    'mysqld' => {
      'bind_address' => $ipaddress,
    }
  }

  class { '::mysql::server':
    root_password    => $root_password,
    override_options => $override_options
  }

  mysql_user { 'root@%':
   password_hash => mysql_password($root_password),
  }

  mysql_grant { 'root@%':
   privileges => ['all'] ,
   table      => '*.*',
    user => $username,
  }

  mysql_user { $username:
    ensure        => present,
    password_hash => mysql_password($password),
    provider      => 'mysql',
    require       => Class['mysql::server'],
  }

  mysql_grant { "${username}*/*":
    privileges => ['all'],
    provider   => 'mysql',
    require    => Mysql_user[$username],
    table      => '*.*',
    user => $username,
  }

  include mysql::server::mysqltuner

  package { "percona-toolkit": ensure => installed }

}