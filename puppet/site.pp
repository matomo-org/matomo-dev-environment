Exec {
  path => "/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin",
}

$root_dir = "/home/${ssh_username}/www/piwik"

class { 'piwik':
  directory     => $root_dir,
  version       => 'master',
  db_user       => $db_username,
  db_password   => $db_password,
  log_analytics => true,
}

exec { 'try_fix_permission':
  command => "chmod -R a+rw ${root_dir}",
  require => Class['piwik'],
}

piwik::apache { 'apache.piwik':
  port     => 80,
  docroot  => $root_dir,
  priority => '10',
  require  => Class['piwik'],
  user     => $ssh_username,
  group    => $ssh_username,
}

piwik::nginx { 'nginx.piwik':
  port    => 8080,
  docroot => $root_dir,
  require => Class['piwik'],
  user     => $ssh_username,
  group    => $ssh_username,
}
