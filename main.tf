terraform {
  required_providers {
    libvirt = {
      source = "dmacvicar/libvirt"
    }
  }
}

provider "libvirt" {
  # Configuration options
}

resource "libvirt_volume" "ubuntu_disk" {
  name = "ubuntu-20.qcow2"
  pool = "default"
  source = "/var/lib/libvirt/images/ubuntu-20.04.qcow2"
  format = "qcow2"
}

resource "libvirt_domain" "ubuntu_vm" {
  name   = "ubuntu_vm"
  memory = 1024
  vcpu   = 1

  disk {
    volume_id = libvirt_volume.ubuntu_disk.id
  }

  network_interface {
    network_name = "default"
  }

  console {
    type        = "pty"
    target_port = "0"
    target_type = "serial"
  }

  graphics {
    type = "spice"
    listen_type = "none"
  }
}
