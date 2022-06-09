variable "proxmox_host_node" {
  type    = string
  default = "pve"
}

variable "proxmox_password" {
  type      = string
  sensitive = true
}

variable "proxmox_source_template" {
  type    = string
  default = "ubuntu-temp"
}

variable "proxmox_template_name" {
  type    = string
  default = "ubuntu-template"
}

variable "proxmox_url" {
  type    = string
}

variable "proxmox_username" {
  type    = string
  default = "root@pve"
}

variable "proxmox_network_bridge" {
  type    = string
  default = "vmbr0"
}

source "proxmox-clone" "ubuntu" {
  insecure_skip_tls_verify = true
  full_clone = false
  task_timeout = "5m"

  template_name = "${var.proxmox_template_name}"
  clone_vm      = "${var.proxmox_source_template}"
  
  os              = "l26"
  cores           = "1"
  memory          = "512"
  scsi_controller = "virtio-scsi-pci"
  vm_id           = "9000"

  ssh_username = "packer"
  qemu_agent = true

  network_adapters {
    bridge = "${var.proxmox_network_bridge}"
    model  = "virtio"
  }

  node          = "${var.proxmox_host_node}"
  username      = "${var.proxmox_username}"
  password      = "${var.proxmox_password}"
  proxmox_url   = "${var.proxmox_url}"
}

build {
  sources = ["source.proxmox-clone.ubuntu"]

  provisioner "shell" {
    inline = ["sudo cloud-init clean"]
  }
}
