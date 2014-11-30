## Remove xdebug for faster test results
sudo rm /etc/php5/cli/conf.d/20-xdebug.ini
sudo rm /etc/php5/apache2/conf.d/20-xdebug.ini
sudo rm /etc/php5/fpm/conf.d/20-xdebug.ini

## install redis
wget http://download.redis.io/redis-stable.tar.gz
tar xvzf redis-stable.tar.gz
cd redis-stable
make
sudo make install
sudo mkdir /etc/redis
sudo mkdir /var/redis
sudo cp utils/redis_init_script /etc/init.d/redis_6379
sudo cp redis.conf /etc/redis/6379.conf
sudo mkdir /var/redis/6379
### edit configuration file as explained in http://redis.io/topics/quickstart to daemonize redis => `sudo vim /etc/redis/6379.conf`
### then `sudo update-rc.d redis_6379 defaults`
### then `/etc/init.d/redis_6379 start`
cd ..

## install phpredis
wget https://github.com/nicolasff/phpredis/archive/2.2.5.zip -O php-redis.zip && unzip php-redis.zip
cd phpredis-2.2.5/ && phpize && ./configure && make && sudo make install
cd ..
rm -rf phpredis-2.2.5
rm -f php-redis.zip
sudo echo "extension = redis.so" >> /etc/php5/fpm/conf.d/20-redis.ini
sudo echo "extension = redis.so" >> /etc/php5/cli/conf.d/20-redis.ini
sudo echo "extension = redis.so" >> /etc/php5/apache2/conf.d/20-redis.ini

## Prepare configs
## cp README /home/ubuntu/README
## cp www/piwik/config/config.ini.php /home/ubuntu/www/piwik/config/config.ini.php
## cp etc/mysql/my.cnf /etc/mysql/my.cnf
## todo update apparmor for load infile support

## only do this on AWS or only on a server where you only want to execute tests
## sudo mkdir /tmp/ramdisk
## sudo mount -t tmpfs -o size=1536M tmpfs /tmp/ramdisk/
## sudo mv /var/lib/mysql /tmp/ramdisk/mysql
## sudo ln -s /tmp/ramdisk/mysql/ /var/lib/mysql
## sudo chmod -R 770 /var/lib/mysql
## sudo chown -R ubuntu:ubuntu /var/lib/mysql

## Restart services
sudo service mysql restart
sudo service apache2 restart
sudo /etc/init.d/php5-fpm restart

## Install packages needed for UI tests (fonts + phantomjs 1.9.8, tests do not work with the PhantomJS version provided by Ubuntu)
sudo add-apt-repository "deb http://us-east-1.ec2.archive.ubuntu.com/ubuntu/ trusty multiverse"
sudo add-apt-repository "deb-src http://us-east-1.ec2.archive.ubuntu.com/ubuntu/ trusty multiverse"
sudo add-apt-repository "deb http://us-east-1.ec2.archive.ubuntu.com/ubuntu/ trusty-updates multiverse"
sudo add-apt-repository "deb-src http://us-east-1.ec2.archive.ubuntu.com/ubuntu/ trusty-updates multiverse"
sudo apt-get update
sudo apt-get install ttf-mscorefonts-installer

cd /usr/local/share/
sudo wget https://bitbucket.org/ariya/phantomjs/downloads/phantomjs-1.9.8-linux-x86_64.tar.bz2
sudo tar xjf phantomjs-1.9.8-linux-x86_64.tar.bz2
sudo ln -s /usr/local/share/phantomjs-1.9.8-linux-x86_64/bin/phantomjs /usr/local/share/phantomjs
sudo ln -s /usr/local/share/phantomjs-1.9.8-linux-x86_64/bin/phantomjs /usr/local/bin/phantomjs
sudo ln -s /usr/local/share/phantomjs-1.9.8-linux-x86_64/bin/phantomjs /usr/bin/phantomjs
cd
