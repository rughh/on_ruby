Vagrant::Config.run do |config|
  config.vm.customize ["modifyvm", :id, "--name", "onruby", "--memory", "512"]
  config.vm.box = "precise_64_with_ruby193"
  config.vm.host_name = "onruby.de"
  config.vm.forward_port 22, 2222, :auto => true
  config.vm.forward_port 80, 4567
  config.vm.network :hostonly, "176.58.97.120"

  config.vm.provision :puppet do |puppet|
    puppet.manifests_path = "manifests"
    puppet.module_path    = "modules"
    puppet.manifest_file  = "base.pp"
  end
end
