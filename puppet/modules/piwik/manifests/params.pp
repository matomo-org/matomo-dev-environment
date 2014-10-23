# = Class: piwik::params
# 
# This class manages Piwik parameters
# 
# == Parameters: 
# 
# == Requires: 
# 
# == Sample Usage:
#
# This class file is not called directly
#
class piwik::params {
  $user    = $ssh_username
  $group   = $ssh_username
  $docroot = '/var/www/piwik'

  $git_repository = 'https://github.com/piwik/piwik.git'
  $piwik_version  = 'trunk'

  $db_user     = 'piwik@localhost'
  $db_password = 'secure'
}
