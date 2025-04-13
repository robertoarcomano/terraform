terraform {
  required_providers {
    libvirt = {
      source  = "dmacvicar/libvirt"
      version = "0.8.3"
    }
  }
}

provider "libvirt" {
  uri = "qemu:///system"
}

locals {
  disk_size_bytes    = var.disk_size * 1024 * 1024 * 1024
  ram_size_megabytes = var.memory * 1024
}
data "template_file" "user_data" {
  template = <<-EOF
    #cloud-config
    hostname: ${var.name}
    users:
      - name: ubuntu
        sudo: ALL=(ALL) NOPASSWD:ALL
        groups: users, admin
        home: /home/ubuntu
        shell: /bin/bash
        lock_passwd: false
        password: "$6$6Ojewgn3GbjdDfFk$tBbZ2RzgiBexWqWtaLcPKusS/TGmr9q97z95Zu.DXyrV9tro0AjsCrTG5SvcbLh6xxCuFOIBXtRpz3A.LLXq61"
        ssh_authorized_keys:
        - ${file("~/.ssh/id_rsa.pub")}
    EOF
}
resource "libvirt_cloudinit_disk" "cloud_init" {
  name      = "cloud-init.iso"
  pool      = var.pool_disk
  user_data = data.template_file.user_data.rendered
}
resource "libvirt_volume" "base_volume" {
  name = "base-volume"
  pool = var.pool_disk
  # source = "https://cloud-images.ubuntu.com/jammy/current/jammy-server-cloudimg-amd64.img"
  source = "/var/lib/libvirt/images/ubuntu-20.04.qcow2"
  format = "qcow2"
}
resource "libvirt_volume" "vm_volume" {
  name           = "vm-volume"
  base_volume_id = libvirt_volume.base_volume.id
  pool           = var.pool_disk
  size           = local.disk_size_bytes
}

resource "libvirt_domain" "vm" {
  name      = var.name
  memory    = local.ram_size_megabytes
  vcpu      = var.vcpu
  cloudinit = libvirt_cloudinit_disk.cloud_init.id

  network_interface {
    network_name = "default"
  }

  disk {
    volume_id = libvirt_volume.vm_volume.id
  }

  console {
    type        = "pty"
    target_port = "0"
    target_type = "serial"
  }

  graphics {
    type        = "spice"
    listen_type = "address"
    autoport    = true
  }
}

output "vm_name" {
  value = libvirt_domain.vm.name
}
