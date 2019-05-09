Piwik Development Environment
=====================

This configuration makes it very easy to start with Piwik development or to give Piwik a try in your local environment. It'll setup a virtual machine including everything you need to run Piwik. The Piwik project itself will be cloned into a shared/synced folder `www/piwik` which makes it easy to change files within your host IDE. You even do not need to run the VM to change something. 

Need more information? Have a look here: http://piwik.org/blog/2012/08/get-started-with-piwik-development-with-puppet-and-vagrant/

### Docker

This is work in progress

#### Available boxes
 * Ubuntu 14.04
 
#### Installation
 1. Install [Docker](https://www.docker.com/)
 2. Clone this repository including all submodules (`git clone --recursive https://github.com/piwik/piwik-dev-environment.git`)
 3. Build `docker build -t piwikdev .`
 4. Run `docker run -d piwikdev`

### Vagrant

#### Available boxes
 * Ubuntu 14.04
 
#### Installation 
 1. Install [Vagrant](http://www.vagrantup.com)
 2. Clone this repository including all submodules (`git clone --recursive https://github.com/piwik/piwik-dev-environment.git`)
 3. This step is optional. If you want any changes of the defaults, you can make changes in a local vagrant configuration. Have a look at `vagrantconfig.yaml` for a list of possible settings.

 `cp vagrantconfig_local.yaml-dist vagrantconfig_local.yaml`
 
##### With VirtualBox
 4. Install [VirtualBox](https://www.virtualbox.org)
 5. Execute the command `vagrant up` within the root folder
 6. That's it. It'll take some time when executing this command the first time. It'll download the Vagrant base box once and install all required packages.
 7. Don't forget to update your local hosts file. You have to add "apache.piwik" as well as "nginx.piwik".

##### With Amazon AWS
 4. `vagrant plugin install vagrant-aws`
 5. Provide AWS keyname, access key & secret key in `vagrantconfig_local.yaml`
 6. `vagrant up --provider=aws`
 7. Execute `puppet/files/setup.sh` once (we should add this to Puppet)
 
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
