# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  # Every Vagrant virtual environment requires a box to build off of.
  config.vm.box = "chef/centos-6.5"

  config.vm.network :private_network, ip: "33.33.33.20"
  config.ssh.forward_agent = true

  config.vm.provision :shell, path: "provision/bootstrap.sh"

  # Example of shared folder
  config.vm.synced_folder "application", "/var/www/logistics-engine", id: "application", :nfs => true

  if Vagrant.has_plugin?("vagrant-cachier")
    config.cache.scope = :machine

    config.cache.synced_folder_opts = {
      type: :nfs,
      mount_options: ['rw', 'vers=3', 'tcp', 'nolock']
    }

    config.cache.enable :generic, {
      "cache"  => { cache_dir: "/var/www/logistics-engine/app/cache" },
      "logs"   => { cache_dir: "/var/www/logistics-engine/app/logs" },
      "vendor" => { cache_dir: "/var/www/logistics-engine/vendor" },
    }
  end

  # Create a private network, which allows host-only access to the machine
  # using a specific IP.
  # config.vm.network "private_network", ip: "192.168.33.10"

  config.vm.provider "virtualbox" do |vb|
     # Use VBoxManage to customize the VM. For example to change memory:
     vb.customize ["modifyvm", :id, "--memory", "2048"]
  end

end
