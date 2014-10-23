# = Definition: piwik::repo
#
# This definition clones a specific version from a Piwik
# repository into the specified directory.
#
# == Parameters: 
#
# $directory::     The piwik repository will be checked out/cloned into this 
#                  directory.
# $version::       The Piwik version. Defaults to 'trunk'. 
#                  Valid values: For example 'HEAD', 'tags/1.8.3' or 'branch/whatever'.
#
# == Actions:
#
# == Requires: 
#
# == Sample Usage:
#
#  piwik::repo { 'piwik_repo_simple': }
#
#  piwik::repo { 'piwik_repo_full':
#    directory    => '/var/www/piwik',
#    version      => 'trunk',
#  }
#
define piwik::repo(
  $directory    = $piwik::params::docroot,
  $version      = $piwik::params::piwik_version
) {

  if ! defined(File[$directory]) {
    file { "${directory}": }
  }

  vcsrepo { "${directory}":
    ensure   => present,
    provider => git,
    source   => $piwik::params::git_repository,
    revision => $version,
    owner    => $piwik::params::user,
    group    => $piwik::params::group,
    require  => [ Class['git'] ],
  }

  file { "${directory}/config":
    ensure    => directory,
    mode      => '0777',
    subscribe => Vcsrepo["${directory}"],
  }

  file { "${directory}/tmp":
    ensure    => directory,
    mode      => '0777',
    subscribe => Vcsrepo["${directory}"],
  }

}
