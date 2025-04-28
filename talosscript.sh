#!/bin/bash

export TALOSCONFIG=$(realpath ./talosconfigs/talosconfig)
control=($(virsh list | grep "talos" | grep "control" | awk '{print $2}' | xargs -L1 virsh domifaddr | awk '/ipv4/{print $4}' | grep 172.28.128 | cut -d'/' -f1))
worker=($(virsh list | grep "talos" | grep "worker" | awk '{print $2}' | xargs -L1 virsh domifaddr | awk '/ipv4/{print $4}' | grep 172.28.128 | cut -d'/' -f1))
talosctl gen config talos-libvirt https://172.28.128.3:6443 --install-disk /dev/vda --output talosconfigs --config-patch @talospatches/all.yaml --config-patch-control-plane @talospatches/controlplane.yaml --config-patch-worker @talospatches/worker.yaml --force
talosctl config endpoint ${control[@]}
talosctl -n ${control[0]} apply-config --insecure --file talosconfigs/controlplane.yaml
sleep 300
talosctl -n ${control[0]} bootstrap
for i in "${control[@]:1}"; do
    talosctl -n $i apply-config --insecure --file talosconfigs/controlplane.yaml
done
for i in "${worker[@]}"; do
    talosctl -n $i apply-config --insecure --file talosconfigs/worker.yaml
done
talosctl -n ${control[0]} kubeconfig ./kubeconfig --force