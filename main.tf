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

module "vm" {
  for_each = {
    for vm in [
      { name = "terraform1", memory = 1, vcpu = 1, disk_size = 10 },
      { name = "terraform2", memory = 2, vcpu = 1, disk_size = 10 },
      { name = "terraform3", memory = 3, vcpu = 1, disk_size = 10 }
    ] : 
    vm.name => {
      memory    = vm.memory
      vcpu      = vm.vcpu
      disk_size = vm.disk_size
    }
  }
  source    = "./modules/vm"
  name      = each.key
  memory    = each.value.memory
  vcpu      = each.value.vcpu
  disk_size = each.value.disk_size
}

# Output 
output "message" {
  value       = "VMs created: ${join(", ", [for vm in module.vm : vm.vm_name])}"
  description = "VM Created"
}
