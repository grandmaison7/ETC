# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|

    # serveur utilisateurs
      config.vm.define "srv-user" do |machine|
        machine.vm.hostname = "srv-user"
        machine.vm.box = "debian/buster64"
        machine.vm.network :private_network, ip: "192.168.56.82"
       # machine.vm.synced_folder "./files", "/vagrant_files"
            #owner: "root", group: "root"
        #SharedFoldersEnableSymlinksCreate: false
        #machine.vm.synced_folder "./logs", "/home/vagrant/logs"
        machine.vm.provider :virtualbox do |v|
          v.customize ["modifyvm", :id, "--name", "srv-user"]
          v.customize ["modifyvm", :id, "--groups", "/S8-projet"]
          v.customize ["modifyvm", :id, "--cpus", "1"]
          v.customize ["modifyvm", :id, "--memory", 1024]
          v.customize ["modifyvm", :id, "--natdnshostresolver1", "off"]
          v.customize ["modifyvm", :id, "--natdnsproxy1", "off"]
        end
        config.vm.provision "shell", inline: <<-SHELL
          sed -i 's/ChallengeResponseAuthentication no/ChallengeResponseAuthentication yes/g' /etc/ssh/sshd_config    #sed = chercher/remplacer
          sleep 3
          service sshd restart
        SHELL
        machine.vm.provision "shell", path: "scripts/install_sys.sh"
        machine.vm.provision "shell", path: "scripts/install_moodle.sh"
      end
    end
    