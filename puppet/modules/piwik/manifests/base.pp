# = Class: piwik::base
# 
# This class installes some base packages like git, subversion, vim
# and more.
# 
# == Parameters: 
# 
# == Requires: 
# 
# == Sample Usage:
#
#  include piwik::base
#
class piwik::base {

  include apt

  notify {"apt-get_update": }

  exec { "base_apt-get_update": command => "apt-get update" }

  package { 'vim': ensure => installed, require => Exec['base_apt-get_update'] }

  package { 'subversion': ensure => installed, require => Exec['base_apt-get_update'] }

  package { 'facter': ensure => latest, require => Exec['base_apt-get_update'] }

  package { 'dnsutils': ensure => latest, require => Exec['base_apt-get_update'] }

  package { 'sendmail': ensure => latest, require => Exec['base_apt-get_update'] }

  package { 'strace': ensure => latest, require => Exec['base_apt-get_update'] }

  package { 'telnet': ensure => latest, require => Exec['base_apt-get_update'] }

  package { 'nmap': ensure => latest, require => Exec['base_apt-get_update'] }

  package { 'apache2-utils': ensure => latest, require => Exec['base_apt-get_update'] }

  package { 'net-tools': ensure => latest, require => Exec['base_apt-get_update'] }

  package { 'tcpdump': ensure => latest, require => Exec['base_apt-get_update'] }

  package { 'wget': ensure => latest, require => Exec['base_apt-get_update'] }

  package { 'curl': ensure => latest, require => Exec['base_apt-get_update'] }

  package { 'cutycapt': ensure => latest, require => Exec['base_apt-get_update'] }

  package { 'language-pack-DE': ensure => latest, require => Exec['base_apt-get_update'] }

  package { 'imagemagick': ensure => latest, require => Exec['base_apt-get_update'] }

  package { 'imagemagick-doc': ensure => latest, require => Exec['base_apt-get_update'] }

  package { 'unzip': ensure => latest, require => Exec['base_apt-get_update'] }

  package { 'iftop': ensure => latest, require => Exec['base_apt-get_update'] }

  package { 'iotop': ensure => latest, require => Exec['base_apt-get_update'] }

  package { 'htop': ensure => latest, require => Exec['base_apt-get_update'] }

  package { 'inetutils-ping': ensure => latest, require => Exec['base_apt-get_update'] }

  package { 'netcat': ensure => latest, require => Exec['base_apt-get_update'] }
  
  package { 'openjdk-7-jre-headless': ensure => latest, require => Exec['base_apt-get_update'] }

  package { 'xmlstarlet': ensure => latest, require => Exec['base_apt-get_update'] }

  include git
}
