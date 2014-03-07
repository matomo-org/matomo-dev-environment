# = Class: piwik::loganalytics
# 
# This class installes all required packages in order to use
# Log Analytics. Those packages are also required to run the
# Log Analytics integration tests.
# 
# == Parameters: 
# 
# == Requires: 
# 
# == Sample Usage:
#
#  include piwik::loganalytics
#
class piwik::loganalytics {

  if ! defined(Package['build-essential']) {
    package { 'build-essential':
      ensure => latest,
    }
  }
  
  package {
    'python-setuptools':
        ensure => latest;
    'python-dev':
        ensure => latest;
  }

  exec { "easy_install_pip":
    command => "easy_install pip",
    require => [ Package['python-setuptools'], Package['python-dev'], Package['build-essential'] ],
    unless  => "which pip";
  }

  package { 'simplejson': 
    ensure   => installed, 
    provider => 'pip', 
    require  => Exec['easy_install_pip']}

}