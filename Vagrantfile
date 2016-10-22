# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|
  config.vm.box = "centos/7"

  config.vm.network "private_network", type: "dhcp"

  config.vm.network "forwarded_port", guest: 8500, host: 8500

  config.vm.provider "virtualbox" do |v|
    v.memory = 1028
    v.cpus = 1
  end

  # You may need to install this plugin
  # vagrant plugin install vagrant-vbguest
  config.vbguest.auto_update = true

  config.vm.boot_timeout = 5000

  # If true, then any SSH connections made will enable agent forwarding.
  config.ssh.forward_agent = true

  # Share additional folders to the guest VM.
  config.vm.synced_folder "consul-conf/", "/etc/consul.d/"
  config.vm.synced_folder "experiments/", "/home/vagrant/experiments/"

  # Install consul
  config.vm.provision "shell", path: "provision/setup.sh"

  # Upload user's ssh key into box so it can be used for downloading stuff from github
  ssh_key_path = "~/.ssh/"
  config.vm.provision "shell", inline: "mkdir -p /home/vagrant/.ssh"
  config.vm.provision "file", source: "#{ ssh_key_path + 'id_rsa' }", destination: "/home/vagrant/.ssh/id_rsa"
  config.vm.provision "file", source: "#{ ssh_key_path + 'id_rsa.pub' }", destination: "/home/vagrant/.ssh/id_rsa.pub"

end