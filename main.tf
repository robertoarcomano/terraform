module "vm1" {
  source      = "./modules/vm"
  name        = "terraform1"
  memory      = 1
  vcpu        = 1
  disk_size   = 10
  pool_disk   = "default"
}
module "vm2" {
  source      = "./modules/vm"
  name        = "terraform2"
  memory      = 1
  vcpu        = 1
  disk_size   = 10
  pool_disk   = "default"
}   
module "vm3" {
  source      = "./modules/vm"
  name        = "terraform3"
  memory      = 1
  vcpu        = 1
  disk_size   = 10
  pool_disk   = "default"
}   
# Output 
output "message" {
  value       = "VM ${module.vm1.vm_name} ${module.vm2.vm_name} ${module.vm2.vm_name} created"
  description = "VM Created"
}
