variable "name" {
  type    = string
  default = "vm"
}

variable "memory" {
  type    = number
  default = 1
}

variable "vcpu" {
  type    = number
  default = 1
}

variable "disk_size" {
  type    = number
  default = 1
}

variable "pool_disk" {
  type    = string
  default = "pool_disk"
}
