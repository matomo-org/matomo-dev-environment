Exec {
  path => "/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin",
}

class { 'piwik':
  directory     => '/home/vagrant/www/piwik',
  repository    => 'git',
  version       => 'master',
  db_user       => $db_username,
  db_password   => $db_password,
  log_analytics => true,
}

piwik::apache { 'apache.piwik':
  port     => 80,
  docroot  => '/home/vagrant/www/piwik',
  priority => '10',
  require  => Class['piwik'],
  user     => 'vagrant',
  group    => 'vagrant',
}

piwik::nginx { 'nginx.piwik':
  port    => 8080,
  docroot => '/home/vagrant/www/piwik',
  require => Class['piwik'],
  user     => 'vagrant',
  group    => 'vagrant',
}
