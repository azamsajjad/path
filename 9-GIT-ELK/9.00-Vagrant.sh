VagrantFile

Vagrant.configure("2") do |config|
  config.vm.box = "geerlingguy/centos7"

  config.ssh.insert_key = false
  config.vm.synced_folder".", "/vagrant", disabled: true
  config.vm.provider :vmware do |v|
    v.memory = 512
    v.linked_clone = true
  end

  # App Server 1
  config.vm.define "app1" do |app|
    app.vm.hostname = "orc-app1.test"
    app.vm.network :private_network, ip: "192.168.56.101"
  end

  # App Server 3
  config.vm.define "db" do |db|
    db.vm.hostname = "orc-db.test"
    db.vm.network :private_network, ip: "192.168.56.102"
  end

end
