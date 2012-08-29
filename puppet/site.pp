Exec {
  path => "/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin",
}

class { 'piwik':
  directory     => '/var/www/piwik',
  repository    => $repository,
  version       => 'trunk',
  db_user       => $db_username,
  db_password   => $db_password,
  log_analytics => true,
  svn_username  => $svn_username,
  svn_password  => $svn_password,
}

piwik::apache { 'apache.piwik':
  port     => 80,
  docroot  => '/var/www/piwik',
  priority => '10',
  require  => Class['piwik'],
}

piwik::nginx { 'nginx.piwik':
  port    => 8080,
  docroot => '/var/www/piwik',
  require => Class['piwik'],
}
