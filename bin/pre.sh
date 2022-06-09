#!/bin/bash

TMP_IMG_NAME="/tmp/ubuntu.qcow2"

TEMPL_NAME="ubuntu-temp"
VMID="8999"
MEM="512"
DISK_SIZE="10G"

wget -O $TMP_IMG_NAME $CLOUD_INIT_IMAGE_URL

virt-customize --install qemu-guest-agent -a $TMP_IMG_NAME

qm destroy 9000 --purge

qm create $VMID --name $TEMPL_NAME --memory $MEM --net0 virtio,bridge=$PKR_VAR_proxmox_network_bridge
qm importdisk $VMID $TMP_IMG_NAME $PVE_DISK_STORAGE
qm set $VMID --scsihw virtio-scsi-pci --scsi0 $PVE_DISK_STORAGE:vm-$VMID-disk-0
qm set $VMID --ide2 $PVE_DISK_STORAGE:cloudinit
qm set $VMID --boot c --bootdisk scsi0
qm set $VMID --serial0 socket --vga serial0
qm set $VMID --ipconfig0 ip=dhcp
qm resize $VMID scsi0 $DISK_SIZE

qm template $VMID

rm $TMP_IMG_NAME
