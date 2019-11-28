resource "null_resource" "bootstrap" {
  triggers = {
    bootstrap = "${data.template_file.bootstrap.rendered}"
  }
  provisioner "local-exec" {
    command = "${format("cat <<\"EOF\" > \"%s\"\n%s\nEOF", "bootstrap.sh", data.template_file.bootstrap.rendered)}"
  }
}

resource "vsphere_virtual_machine" "vm" {
  count            = "${var.num_vms}"
  name             = "${format("${var.vm_name_prefix}-%02d", count.index + 1)}"
  resource_pool_id = "${data.vsphere_resource_pool.pool.id}"
  datastore_id     = "${data.vsphere_datastore.datastore.id}"

  num_cpus = "${var.vm_num_cpus}"
  memory   = "${var.vm_mem_size}"
  guest_id = "${data.vsphere_virtual_machine.template.guest_id}"

  scsi_type = "${data.vsphere_virtual_machine.template.scsi_type}"

  network_interface {
    network_id   = "${data.vsphere_network.network.id}"
    adapter_type = "${data.vsphere_virtual_machine.template.network_interface_types[0]}"
  }

  disk {
    label            = "disk0"
    size             = "${data.vsphere_virtual_machine.template.disks.0.size}"
    eagerly_scrub    = "${data.vsphere_virtual_machine.template.disks.0.eagerly_scrub}"
    thin_provisioned = "${data.vsphere_virtual_machine.template.disks.0.thin_provisioned}"
  }

  disk {
    label            = "disk1"
    size             = "100"
    eagerly_scrub    = "${data.vsphere_virtual_machine.template.disks.0.eagerly_scrub}"
    thin_provisioned = "${data.vsphere_virtual_machine.template.disks.0.thin_provisioned}"
    unit_number      = 1
  }

  clone {
    template_uuid = "${data.vsphere_virtual_machine.template.id}"

    customize {
      linux_options {
        host_name = "${format("${var.vm_name_prefix}-%02d", count.index + 1)}"
        domain    = "${var.vm_domain_suffix}"
      }

      network_interface {}
    }
  }

  provisioner "local-exec" {
    command = "echo '[all:vars]\nansible_connection=ssh\nansible_user=${var.vm_admin_user}\nansible_ssh_pass=${var.vm_admin_password}\n[all]\n${self.default_ip_address}' > ${self.default_ip_address} && ansible-playbook -i ${self.default_ip_address} bootstrap.yaml"
  }
  provisioner "local-exec" {
    command = "rm -f ${self.default_ip_address}"
  }
}
