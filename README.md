Piwik Development Environment
=====================

This configuration makes it very easy to start with Piwik development or to give Piwik a try in your local environment. It'll setup a virtual machine including everything you need to run Piwik. 

### Available Vagrant Boxes
 * Ubuntu Precise 32
 * Ubuntu Precise 64

### Installation
 1. Install [Vagrant](http://www.vagrantup.com) & [VirtualBox](https://www.virtualbox.org)
 2. Clone this repository and update submodules (`git submodule init && git submodule update`)
 3. Execute the command `vagrant up` within a `vagrant/$box` folder
 4. That's it. It'll take some time when executing this command the first time. It'll download the Vagrant base box once and install all required packages.
 5. Don't forget to update your local hosts file. You have to add "apache.piwik" as well as "nginx.piwik".

### Usage

Open "http://apache.piwik" or "http://nginx.piwik:8080" after installation. You'll see the [Piwik installation](http://piwik.org/docs/installation/#toc-the-5-minute-piwik-installation) screen.

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

You'll find Piwik here: `/var/www/piwik` 

Let us know if you miss something.
