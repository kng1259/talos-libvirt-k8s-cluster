home = ENV['HOME']
isos = "#{home}/.isos/talos-iscsi.iso"
serial = "#{home}/Code/TalosVMs"
nodes = {
    "control-plane-node" => { count: 3, cpus: 2, storage: '15G', memory: 2048 },
    "worker-node" => { count: 3, cpus: 2, storage: '35G', memory: 2048 }
}

Vagrant.configure("2") do |config|
    nodes.each do |node_prefix, specs|
        (1..specs[:count]).each do |i|
            node_name = "#{node_prefix}-#{i}"
            FileUtils.touch("logs/#{node_name}.log")
            config.vm.define node_name do |vm|
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
