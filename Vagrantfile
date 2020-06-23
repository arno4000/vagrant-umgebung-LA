Vagrant.configure("2") do |config|
  config.vm.box = "peru/windows-server-2019-datacenter-x64-eval"
  config.vm.box_version = "20200601.01"
  config.vm.define "srv01" do |srv01|
    srv01.vm.box = "peru/windows-server-2019-datacenter-x64-eval"
	  srv01.vm.hostname = "srv01"
	  #RDP Port must be changed manually. Otherwise RDP will not work
    srv01.vm.network "forwarded_port", guest: 3389, host: 3388, id: "rdp"
    srv01.vm.network :private_network, ip: "192.168.20.10"
  end
  config.vm.define "srv02" do |srv02|
    srv02.vm.box = "peru/windows-server-2019-datacenter-x64-eval"
    srv02.vm.hostname = "srv02"
	  #RDP Port must be changed manually. Otherwise RDP will not work
    srv02.vm.network "forwarded_port", guest: 3389, host: 3387, id: "rdp2"
    srv02.vm.network :private_network, ip: "192.168.20.20"
  end
  config.vm.provider "virtualbox" do |v|
    v.gui = false
  end
end
