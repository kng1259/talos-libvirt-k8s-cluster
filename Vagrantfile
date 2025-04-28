home = ENV['HOME']
isos = "#{home}/.isos/talos-iscsi.iso"
serial = "#{home}/Code/talos-libvirt-k8s-cluster"
nodes = {
    "control-plane-node" => { count: 1, cpus: 2, storage: '20G', memory: 2048 },
    "worker-node" => { count: 3, cpus: 2, storage: '50G', memory: 2048 }
}

Vagrant.configure("2") do |config|

    nodes.each do |node_prefix, specs|
        (1..specs[:count]).each do |i|
            node_name = "#{node_prefix}-#{i}"
            FileUtils.touch("logs/#{node_name}.log")
            config.vm.define node_name do |vm|
                vm.vm.network :private_network, type: "dhcp",
                    :libvirt__network_name => "vagrant-routed",
                    :libvirt__forward_mode => "nat",
                    :libvirt__dhcp_start => "172.28.128.4",
                    :libvirt__dhcp_stop => "172.28.128.100"

                vm.vm.provider :libvirt do |domain|
                    domain.cpus = specs[:cpus]
                    domain.memory = specs[:memory]
                    domain.serial :type => "file", :source => {:path => "#{serial}/logs/#{node_name}.log"}
                    domain.storage :file, :device => :cdrom, :path => isos
                    domain.storage :file, :size => specs[:storage], :type => 'raw'
                    domain.boot 'hd'
                    domain.boot 'cdrom'
                end
            end
        end
    end
end
