variable "ssh-pub-key" {
  # Do not store with your code in git, provide on the commandline!
  default = ""
}

variable "vsphere_user" {
  default = "administrator@vsphere.local"
}

# vsphere account password. empty by default.
variable "vsphere_password" {
  default = "password"
}

# vsphere server, defaults to localhost
variable "vsphere_server" {
  default = "example.vcenter.org"
}

# S3 bucket info
variable "bucket" {}
variable "key" {}
variable "region" {}

