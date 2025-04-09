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
  pool_name = "default" # Usa il pool standard di libvirt che esiste già
}

# Volume base per l'immagine del sistema operativo
resource "libvirt_volume" "base_volume" {
  name   = "base-volume"
  pool   = local.pool_name
  source = "https://cloud-images.ubuntu.com/jammy/current/jammy-server-cloudimg-amd64.img"
  format = "qcow2"
}

# Volume per la VM
resource "libvirt_volume" "vm_volume" {
  name           = "vm-volume"
  base_volume_id = libvirt_volume.base_volume.id
  pool           = local.pool_name
  size           = 10737418240 # 10GB
}

# Configurazione cloud-init
data "template_file" "user_data" {
  template = <<-EOF
    #cloud-config
    
    # Configurazioni aggiuntive se necessarie
    hostname: terraform-vm
    users:
      - name: ubuntu
        sudo: ALL=(ALL) NOPASSWD:ALL
        groups: users, admin
        home: /home/ubuntu
        shell: /bin/bash
        lock_passwd: false
        ssh_authorized_keys:
        - ${file("~/.ssh/id_rsa.pub")}
    EOF
}

resource "libvirt_cloudinit_disk" "cloud_init" {
  name      = "cloud-init.iso"
  pool      = local.pool_name
  user_data = data.template_file.user_data.rendered
}

# Definizione della VM
resource "libvirt_domain" "vm" {
  name   = "terraform-vm"
  memory = "2048"
  vcpu   = 3

  cloudinit = libvirt_cloudinit_disk.cloud_init.id

  network_interface {
    network_name = "default" # Usa la rete default di libvirt
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

# Output
output "vm_name" {
  value       = libvirt_domain.vm.name
  description = "Il nome della VM creata"
}

output "connection_instructions" {
  value       = "Connettiti alla VM usando: ssh ubuntu@<IP_ADDRESS> (quando disponibile)"
  description = "Istruzioni per la connessione"
}