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
  $username = "${piwik::params::user}"
    
  # user for apache / nginx
  if $username != $id {
    if ! defined(User[$username]) {
        user { $username:
          ensure  => present,
          comment => $username
        }
    }

  }

}
