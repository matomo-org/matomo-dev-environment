# = Class: piwik::user
# 
# Makes sure the user exists which is used by Apache and NGINX.
# 
# == Parameters: 
# 
# == Requires: 
# 
# == Sample Usage:
#
#  include piwik::user
#
class piwik::user {
    
  # user for apache / nginx
  user { "${piwik::params::user}":
    ensure  => present,
    comment => $piwik::params::user,
    shell   => '/bin/false',
  }

}
