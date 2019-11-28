# # number of vms to clone
variable "num_vms" {}
variable "vm_mem_size" {}
variable "vm_num_cpus" {}
variable "vm_name_prefix" {}

variable "vm_domain_suffix" {}

variable "vm_admin_user" {}
variable "vm_admin_password" {}

variable "ssh-pub-key" {}

# vsphere datacenter the virtual machine will be deployed to. empty by default.
variable "vsphere_datacenter" {}

# vsphere resource pool the virtual machine will be deployed to. empty by default.
variable "vsphere_resource_pool" {}

# vsphere datastore the virtual machine will be deployed to. empty by default.
variable "vsphere_datastore" {}

# vsphere network the virtual machine will be connected to. empty by default.
variable "vsphere_network" {}

# vsphere virtual machine template that the virtual machine will be cloned from. empty by default.
variable "vsphere_virtual_machine_template" {}
