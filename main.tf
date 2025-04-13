module "vm" {
  source      = "./modules/vm"
  name        = "terraform"
  memory      = 3
  vcpu        = 6      
  disk_size   = 30
  pool_disk   = "default"
}
   
# Output 
output "message" {
  value       = "VM ${module.vm.vm_name} created"
  description = "VM Created"
}
