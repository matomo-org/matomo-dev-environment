
class piwik::xhprof {

  if ! defined(Package['build-essential']) {
    package { 'build-essential':
      ensure => present,
    }
  }
  if ! defined(Package['php5-common']) {
    package { 'php5-common':
      ensure => present,
    }
  }

  if ! defined(Package['php-pear']) {
    package { 'php-pear':
      ensure => present,
    }
  }

  exec { 'xhprof-install':
    command => 'pecl install pecl.php.net/xhprof-0.9.3',
    creates => '/usr/share/php/xhprof_html',
    require => [Package['build-essential'], Package['php-pear']],
  }

  file { '/etc/php5/conf.d/xhprof.ini':
    source  => 'puppet:///modules/piwik/etc/php5/conf.d/xhprof.ini',
    require => Exec['xhprof-install'],
  }

}