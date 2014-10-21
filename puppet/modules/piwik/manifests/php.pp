# = Class: piwik::php
# 
# This class installs PHP including all modules required by Piwik.
# Lots of useful PHP QA packages and Composer will be installed as well.
# 
# == Parameters: 
# 
# == Requires: 
# 
# == Sample Usage:
#
#  include piwik::php
#
class piwik::php {

  class { '::php':
    manage_repos => true,
    fpm          => true,
    dev          => true,
    composer     => true,
    pear         => true,
    phpunit      => false,
    extensions   => {}
  }

}
