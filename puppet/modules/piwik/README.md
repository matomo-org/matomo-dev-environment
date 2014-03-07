puppet-piwik module
============

### Piwik - Open source web analytics

Piwik is downloadable, Free/Libre real time web analytics software. It provides you with detailed reports on your website visitors; the search engines and keywords they used, the language they speak, your popular pages, and much more.

### License: 
GPL v3 or later

### Link: 
http://piwik.org

### Issues:
Let us know if something is missing or going wrong. Just create a ticket here: [http://dev.piwik.org/trac](http://dev.piwik.org/trac)

## How to use

### Simple Example:
```
Exec {
  path => "/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin",
}

class { 'piwik': }
piwik::apache { 'apache.piwik': }
```

### Full example:
```
Exec {
  path => "/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin",
}

class { 'piwik':
  directory     => '/var/www/piwik',
  repository    => 'svn',
  version       => 'trunk',
  db_user       => 'username',
  db_password   => 'secure',
  log_analytics => true,
  svn_username  => 'myusername',
  svn_password  => 'mypassword',
}

piwik::apache { 'apache.piwik':
  port     => 80,
  docroot  => '/var/www/piwik',
  priority => '10',
  require  => Class['piwik'],
  user     => 'piwik',
  group    => 'www',
}

piwik::nginx { 'nginx.piwik':
  port    => 8080,
  docroot => '/var/www/piwik',
  require => Class['piwik'],
  user    => 'piwik',
  group   => 'www',
}
```

### Add further Piwik versions/hosts:
```
piwik::repo { 'piwik_repo_17':
  directory  => '/var/www/piwik17',
  version    => 'tags/1.7',
  repository => 'svn',
  require    => Class['piwik'],
}

piwik::nginx { 'version17.piwik':
  port     => 8170,
  docroot  => '/var/www/piwik17',
  require  => Piwik::Repo['piwik_repo_17'],
}
```

Do not forget to update your local hosts file when adding servers.

### Requirements
* puppetlabs-apache - https://github.com/puppetlabs/puppetlabs-apache 
* puppet-apt - https://github.com/camptocamp/puppet-apt
* puppet-augeas - https://github.com/camptocamp/puppet-augeas
* puppet-common - https://github.com/puppet-modules/puppet-common
* puppetlabs-firewall - https://github.com/puppetlabs/puppetlabs-firewall
* puppetlabs-git - https://github.com/puppetlabs/puppetlabs-git
* puppetlabs-mysql - https://github.com/puppetlabs/puppetlabs-mysql
* puppetlabs-nginx - https://github.com/Mayflower/puppetlabs-nginx
* puppet-pear - https://github.com/treehouseagency/puppet-pear
* puppet-php - https://github.com/Mayflower/puppet-php
* rafaelfc-phpqatools - https://github.com/rafaelfelix/puppet-phpqatools
* puppetlabs-stdlib - https://github.com/puppetlabs/puppetlabs-stdlib
* puppet-vcsrepo - https://github.com/openstack-infra/puppet-vcsrepo 
* puppet-concat - https://github.com/ripienaar/puppet-concat

```
git submodule add git://github.com/puppetlabs/puppetlabs-apache modules/apache
git submodule add git://github.com/camptocamp/puppet-apt modules/apt
git submodule add git://github.com/camptocamp/puppet-augeas modules/augeas
git submodule add git://github.com/puppet-modules/puppet-common modules/common
git submodule add git://github.com/puppetlabs/puppetlabs-firewall modules/Firewall
git submodule add git://github.com/puppetlabs/puppetlabs-git modules/git
git submodule add git://github.com/puppetlabs/puppetlabs-mysql modules/mysql
git submodule add git://github.com/Mayflower/puppetlabs-nginx modules/nginx
git submodule add git://github.com/treehouseagency/puppet-pear modules/pear
git submodule add git://github.com/Mayflower/puppet-php modules/php
git submodule add git://github.com/rafaelfelix/puppet-phpqatools modules/phpqatools
git submodule add git://github.com/puppetlabs/puppetlabs-stdlib modules/stdlib
git submodule add git://github.com/openstack-infra/puppet-vcsrepo modules/vcsrepo
git submodule add https://github.com/ripienaar/puppet-concat.git modules/concat
```
