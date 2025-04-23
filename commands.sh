curl -X POST --data-binary @image.yaml https://factory.talos.dev/schematics
talosctl gen config talos-libvirt https://192.168.121.3:6443 --install-disk /dev/vda --output talosconfigs --config-patch @talospatches/all.yaml --config-patch-control-plane @talospatches/controlplane.yaml --config-patch-worker @talospatches/worker.yaml
virsh list | grep talos | awk '{print $2}' | xargs -L1 virsh domifaddr | awk '/ipv4/{print $4}' | cut -d'/' -f1 | tr '\n' ' ' | sed 's/ $//'
virsh list | grep talos | awk '{print $2}' | xargs -L1 virsh domifaddr | awk '/ipv4/{print $4}' | cut -d'/' -f1 | tr '\n' ' ' | sed 's/ $//' | xargs talosctl config endpoint
talosctl apply-config
talosctl bootstrap
talosctl kubeconfig