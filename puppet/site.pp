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

host { 'xhrof.piwik':
  ip => "127.0.0.1",
} 

apache::vhost { 'xhprof.piwik':
  docroot     => '/usr/share/php/xhprof_html',
  priority    => '20',
  port        => '80',
  ssl         => false,
  override    => 'All',
  require     => Piwik::Apache['apache.piwik'],
  logroot     => '/var/log/xhprof.piwik'
}