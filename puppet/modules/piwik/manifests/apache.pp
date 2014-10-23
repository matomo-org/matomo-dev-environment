# = Definition: piwik::apache
#
# This definition installs Apache2 including some modules like
# mod_rewrite and creates a virtual host.
#
# == Parameters: 
#
# $name::      The name of the host
# $port::      The port to configure the host
# $priority::  The priority of the site
# $docroot::   The location of the files for this host
# $user::      Under which user apache should run
# $group::     Under which group apache should run
#
# == Actions:
#
# == Requires: 
#
# The piwik class
#
# == Sample Usage:
#
#  piwik::apache { 'apache.piwik': }
#
#  piwik::apache { 'apache.piwik':
#    port     => 80,
#    priority => '10',
#    docroot  => '/var/www/piwik',
#    user     => 'piwik',
#    group    => 'www'
#  }
#
define piwik::apache (
  $port     = '80',
  $docroot  = $piwik::params::docroot,
  $priority = '10',
  $user     = $piwik::params::user,
  $group    = $piwik::params::group,
) {  

  host { "${name}":
    ip => "127.0.0.1";
  } 

  class { 'apache': 
    user  => $user,
    group => $group,
    mpm_module => 'prefork',
    servername => 'piwikdev',
  }

  include apache::mod::php
  include apache::mod::vhost_alias
  include apache::mod::rewrite

  apache::vhost { "${name}":
    priority   => $priority,
    vhost_name => '_default_',
    port       => $port,
    override   => ['All'],
    docroot    => $docroot,
    require    => [ Host[$name], Piwik::Repo['piwik_repo_setup'], Class['piwik::php'] ],
    servername => $name
  }

}