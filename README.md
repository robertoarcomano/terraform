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
Launch file [network.sh](network.sh) to:
2. (Re)Create and start the **default** network

## 2. Init / Plan / Apply
Execute these commands:
```
terraform init
terraform plan
terraform apply
```

### Bug fixing
There is a bug related to libvirt images directory permissions.
Please follow instructions related to Solution 2 at https://github.com/dmacvicar/terraform-provider-libvirt/issues/1163#issuecomment-2726569845 in order to fix it.

# Help
### Destroy a specific target
```
terraform destroy -target libvirt_volume.vm_volume
terraform destroy -target libvirt_domain.vm
```
