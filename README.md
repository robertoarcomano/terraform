# terraform
Terraform tutorial
## 1. Configuration
### Install terraform
```wget -O - https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list

sudo apt update && sudo apt install terraform
```
Note: For Linux Mint you have to replace the part $(lsb_release -cs) with the ubuntu release your Linux Mint is pointing at, in my case **noble**

Or else you can download the binary from https://releases.hashicorp.com/terraform/1.11.3/terraform_1.11.3_linux_amd64.zip

### Environment configuration
Launch file [network.sh](network.sh) to (re)create and start the **default** network

## 2. Init / Plan / Apply
Execute these commands:
```
terraform init
terraform plan
terraform apply
```

## 3. Other commands
### Validate
```
berto@lap:~/src/terraform$ terraform validate
Success! The configuration is valid.
```
### State
```
berto@lap:~/src/terraform$ terraform state list
data.template_file.user_data
libvirt_cloudinit_disk.cloud_init
libvirt_domain.vm
libvirt_volume.base_volume
libvirt_volume.vm_volume
```
### Show
<details>
  <summary>Show</summary>

    berto@lap:~/src/terraform$ terraform show
    # data.template_file.user_data:
    data "template_file" "user_data" {
        id       = "1c376eee49a4042e8deff73c54d04230e466187f69c784b96d6703d18a968e4f"
        rendered = <<-EOT
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
                - ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAIEAvGHiO8USNTP9pc9gaSXPIqIYcanCgUbaRKB150YMtTEm2j3cBalOOZDeCd4Ex8PWFWqn6pDguBu6YK7lxTLxHiRtM9JvvfeoGgLTjaKoz23J9Z7IC+QCBz/jbVn7HVxyEGhry7/cWW7phrogJq3B5J2zgN6RZPFRlAodGnMvZw8= info@bertolinux.com
        EOT
        template = <<-EOT
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
                - ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAIEAvGHiO8USNTP9pc9gaSXPIqIYcanCgUbaRKB150YMtTEm2j3cBalOOZDeCd4Ex8PWFWqn6pDguBu6YK7lxTLxHiRtM9JvvfeoGgLTjaKoz23J9Z7IC+QCBz/jbVn7HVxyEGhry7/cWW7phrogJq3B5J2zgN6RZPFRlAodGnMvZw8= info@bertolinux.com
        EOT
    }

    # libvirt_cloudinit_disk.cloud_init:
    resource "libvirt_cloudinit_disk" "cloud_init" {
        id             = "/var/lib/libvirt/images/cloud-init.iso;6ab2a6c0-1d57-41e6-954c-4b2a58f4b35a"
        meta_data      = null
        name           = "cloud-init.iso"
        network_config = null
        pool           = "default"
        user_data      = <<-EOT
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
                - ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAIEAvGHiO8USNTP9pc9gaSXPIqIYcanCgUbaRKB150YMtTEm2j3cBalOOZDeCd4Ex8PWFWqn6pDguBu6YK7lxTLxHiRtM9JvvfeoGgLTjaKoz23J9Z7IC+QCBz/jbVn7HVxyEGhry7/cWW7phrogJq3B5J2zgN6RZPFRlAodGnMvZw8= info@bertolinux.com
        EOT
    }

    # libvirt_domain.vm:
    resource "libvirt_domain" "vm" {
        arch        = "x86_64"
        autostart   = false
        cloudinit   = "/var/lib/libvirt/images/cloud-init.iso;6ab2a6c0-1d57-41e6-954c-4b2a58f4b35a"
        description = null
        emulator    = "/usr/bin/qemu-system-x86_64"
        fw_cfg_name = "opt/com.coreos/config"
        id          = "68f15c9e-80da-4f95-b301-d7987346f645"
        initrd      = null
        kernel      = null
        machine     = "pc"
        memory      = 2048
        name        = "terraform-vm"
        qemu_agent  = false
        running     = true
        type        = "kvm"
        vcpu        = 3

        console {
            source_host    = "127.0.0.1"
            source_path    = null
            source_service = "0"
            target_port    = "0"
            target_type    = "serial"
            type           = "pty"
        }

        cpu {
            mode = "custom"
        }

        disk {
            block_device = null
            file         = null
            scsi         = false
            url          = null
            volume_id    = "/var/lib/libvirt/images/vm-volume"
            wwn          = null
        }

        graphics {
            autoport       = true
            listen_address = "127.0.0.1"
            listen_type    = "address"
            type           = "spice"
            websocket      = 0
        }

        network_interface {
            addresses      = []
            bridge         = null
            hostname       = null
            mac            = "52:54:00:D6:5E:43"
            macvtap        = null
            network_id     = "eb307a33-41a2-46af-846b-ba499379c28a"
            network_name   = "default"
            passthrough    = null
            private        = null
            vepa           = null
            wait_for_lease = false
        }
    }

    # libvirt_volume.base_volume:
    resource "libvirt_volume" "base_volume" {
        format = "qcow2"
        id     = "/var/lib/libvirt/images/base-volume"
        name   = "base-volume"
        pool   = "default"
        size   = 2361393152
        source = "https://cloud-images.ubuntu.com/jammy/current/jammy-server-cloudimg-amd64.img"
    }

    # libvirt_volume.vm_volume:
    resource "libvirt_volume" "vm_volume" {
        base_volume_id = "/var/lib/libvirt/images/base-volume"
        format         = "qcow2"
        id             = "/var/lib/libvirt/images/vm-volume"
        name           = "vm-volume"
        pool           = "default"
        size           = 10737418240
    }


    Outputs:

    connection_instructions = "Connettiti alla VM usando: ssh ubuntu@<IP_ADDRESS> (quando disponibile)"
    vm_name = "terraform-vm"

</details>

### Bug fixing
There is a bug related to libvirt images directory permissions.
Please follow instructions related to Solution 2 at https://github.com/dmacvicar/terraform-provider-libvirt/issues/1163#issuecomment-2726569845 in order to fix it.

# Help
### Destroy a specific target
```
terraform destroy -target libvirt_volume.vm_volume
terraform destroy -target libvirt_domain.vm
```
### Enable the log
```
export TF_LOG_PATH=~/src/terraform/log
export TF_LOG=TRACE
```
