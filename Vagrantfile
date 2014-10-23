# -*- mode: ruby -*-
# vi: set ft=ruby :

require "yaml"

_config = YAML.load(File.open(File.join(File.dirname(__FILE__), "vagrantconfig.yaml"), File::RDONLY).read)

begin
    _config.merge!(YAML.load(File.open(File.join(File.dirname(__FILE__), "vagrantconfig_local.yaml"), File::RDONLY).read))
rescue Errno::ENOENT

end

CONF = _config

Vagrant.configure("2") do |config|

  config.vm.hostname = "piwik-trusty64"
  config.vm.box = "trusty64"
  config.vm.box_url = "https://cloud-images.ubuntu.com/vagrant/trusty/current/trusty-server-cloudimg-amd64-vagrant-disk1.box"

  $SSH_USERNAME = 'ubuntu'

  config.vm.synced_folder "puppet/files", "/etc/puppet/files", :nfs => false
  config.vm.network :private_network, ip: "192.168.33.10"
    config.ssh.forward_agent = true

  config.vm.provider :virtualbox do |v, override|
    override.vm.synced_folder "www", "/home/vagrant/www", :nfs => false, :owner => "vagrant"
    v.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
    v.customize ["modifyvm", :id, "--memory", 1024]
    v.customize ["modifyvm", :id, "--name", "piwik-dev"]
  end

  config.vm.provider :aws do |aws, override|
    aws.keypair_name = CONF['aws_keypair_name']
    aws.access_key_id = CONF['aws_access_key_id']
    aws.secret_access_key = CONF['aws_secret_access_key']
    override.vm.box = "ubuntu_aws"
    override.vm.box_url = "https://github.com/mitchellh/vagrant-aws/raw/master/dummy.box"
    override.ssh.private_key_path = CONF['aws_pem_file']
    aws.instance_type = "c3.large"
    aws.security_groups = ['default']
    override.ssh.username = "ubuntu"
    aws.ami = "ami-9eaa1cf6"
    aws.tags = {
      'Name' => 'Piwik Testing',
     }
  end

  $provision_script= <<SCRIPT
  if [[ $(which puppet) != '/usr/local/bin/puppet' ]]; then
    sudo apt-get -y install ruby
    sudo gem install puppet
  fi
SCRIPT
  config.vm.provision :shell, :inline => $provision_script

  config.vm.provision :puppet do |puppet|
    puppet.manifests_path = "puppet"
    puppet.manifest_file  = "site.pp"
    puppet.module_path    = "puppet/modules"
    puppet.hiera_config_path = "hiera.yaml"
    puppet.options = ['--verbose']
    puppet.facter = [
        ['db_username',  CONF['db_username']],
        ['db_password',  CONF['db_password']],
        ['ssh_username', $SSH_USERNAME],
    ]
  end
end
