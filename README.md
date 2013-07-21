Piwik Development Environment
=====================

This configuration makes it very easy to start with Piwik development or to give Piwik a try in your local environment. It'll setup a virtual machine including everything you need to run Piwik. The Piwik project itself will be cloned into a shared/synced folder `www/piwik` which makes it easy to change files within your host IDE. You even do not need to run the VM to change something. 

Need more information? Have a look here: http://piwik.org/blog/2012/08/get-started-with-piwik-development-with-puppet-and-vagrant/

### Available Vagrant Boxes
 * Ubuntu Precise 32
 * Ubuntu Precise 64

### Installation
 1. Install [Vagrant](http://www.vagrantup.com) & [VirtualBox](https://www.virtualbox.org)
 2. Clone this repository including all submodules (`git clone --recursive https://github.com/piwik/piwik-dev-environment.git`)
 3. This step is optional. If you want any changes of the defaults, you can make changes in a local vagrant configuration. Have a look at `vagrantconfig.yaml` for a list of possible settings.

 `cp vagrantconfig_local.yaml-dist vagrantconfig_local.yaml`
 4. Execute the command `vagrant up` within a `vagrant/$box` folder
 5. That's it. It'll take some time when executing this command the first time. It'll download the Vagrant base box once and install all required packages.
 6. Don't forget to update your local hosts file. You have to add "apache.piwik" as well as "nginx.piwik".

### Usage

Open "http://apache.piwik" or "http://nginx.piwik:8080" after installation. You'll see the [Piwik installation](http://piwik.org/docs/installation/#toc-the-5-minute-piwik-installation) screen. XHProf is available under "http://xhprof.piwik".

MySQL listens to the external IP address. Use for instance `192.168.33.10` when trying to install Piwik.

### Installed Packages
 * PHP
 * PHP QA Tools (PHPUnit, PHPMD - PHP Mess Detector, PHP Depend, PHP CodeCoverage, PHP_CodeSniffer, ...)
 * Apache2
 * NGINX & PHP-FPM
 * MySQL
 * Percona-Toolkit
 * Subversion
 * Git
 * Composer
 * XHProf

### Troubleshooting
 * If you get file permission errors install latest VirtualBox Guest Additons: https://github.com/dotless-de/vagrant-vbguest

You'll find Piwik here: `/home/vagrant/www/piwik` 

### Issues
Let us know if something is missing or going wrong. Just create a ticket here: [http://dev.piwik.org/trac](http://dev.piwik.org/trac)

