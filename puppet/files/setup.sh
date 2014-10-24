sudo rm /etc/php5/cli/conf.d/20-xdebug.ini
sudo rm /etc/php5/apache2/conf.d/20-xdebug.ini
sudo rm /etc/php5/fpm/conf.d/20-xdebug.ini
cp www/piwik/config/config.ini.php /home/ubuntu/www/piwik/config/config.ini.php
cp etc/mysql/my.cnf /etc/mysql/my.cnf
sudo service mysql restart
sudo service apache2 restart
sudo /etc/init.d/php5-fpm restart
## todo update apparmor for load infile support
sudo add-apt-repository "deb http://us-east-1.ec2.archive.ubuntu.com/ubuntu/ trusty multiverse"
sudo add-apt-repository "deb-src http://us-east-1.ec2.archive.ubuntu.com/ubuntu/ trusty multiverse"
sudo add-apt-repository "deb http://us-east-1.ec2.archive.ubuntu.com/ubuntu/ trusty-updates multiverse"
sudo add-apt-repository "deb-src http://us-east-1.ec2.archive.ubuntu.com/ubuntu/ trusty-updates multiverse"
sudo apt-get update
sudo apt-get install ttf-mscorefonts-installer