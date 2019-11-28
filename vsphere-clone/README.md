# terraform-vsphere-clone

This will create a given number of VMs with the specified number of vcpus and vmem from a given image template and output their IPs for use in other tools such as Ansible for post install configuration. State file will be created/stored in your AWS S3 bucket and utilized for all future state changes.

## Prerequisites

- [Terraform](https://www.terraform.io/downloads.html)
- A valid *nix vsphere template
- vSphere credentials with vm create/clone permissions
- AWS access and secret key with permissions to read/write to the S3 bucket

## Configuration
Before installation, run:
```sh
 cd dev
 cp main.tf.sample main.tf
```
Update all necessary module parameters based on your environment:
```
  # vsphere vars
  vsphere_datacenter               = "dc01"
  vsphere_resource_pool            = "pool01"
  vsphere_datastore                = "datastore01"
  vsphere_network                  = "VM_Network"
  vsphere_virtual_machine_template = "template01"
  # vm vars
  num_vms           = "6"
  vm_mem_size       = "32768"
  vm_num_cpus       = "8"
  vm_name_prefix    = "test-vm"
  vm_domain_suffix  = "test.example.org"
  vm_admin_user     = "root"
  vm_admin_password = "root"
  ```

Now configure the backend:
```sh
  cp dev.tfbackend.sample dev.tfbackend
```
Update all the necessary parameters based on your environment:
```
  # S3 bucket info
  bucket = "mybucket"
  region = "us-west-2"
  key    = "path/to/dev/terraform.tfstate"
```

## Install

```sh
  terraform init -reconfigure -backend-config=dev.tfbackend
  terraform apply -var "ssh-pub-key=$(cat ~/.ssh/id_rsa.pub)" -auto-approve
```
> **Tip**: Verify the install before applying `terraform plan`


## Destroy

```sh
  terraform destroy
```
> **Tip**: Verify what will be destroyed before actually destroying `terraform plan -destroy`
