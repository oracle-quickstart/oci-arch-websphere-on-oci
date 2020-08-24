## Copyright © 2020, Oracle and/or its affiliates. 
## All rights reserved. The Universal Permissive License (UPL), Version 1.0 as shown at http://oss.oracle.com/licenses/upl

resource "oci_core_instance" "bastion1" {
  count = var.numberOfBastions
  availability_domain = data.oci_identity_availability_domains.ADs.availability_domains[0]["name"]
  compartment_id = var.compartment_ocid
  display_name = "bastion"
  shape = var.InstanceShape

  create_vnic_details {
    subnet_id = oci_core_subnet.vcn01_subnet_bastion01.id
    display_name = "primaryvnic"
    assign_public_ip = true
    nsg_ids = [oci_core_network_security_group.BastionSecurityGroup.id]
  }

  source_details {
    source_type = "image"
    source_id   = lookup(data.oci_core_images.OSImageLocal.images[0], "id")
    boot_volume_size_in_gbs = "50"
  }

  metadata = {
    ssh_authorized_keys = var.ssh_public_key
  }
  # timeouts {
  #   create = "60m"
  # }
}

data "oci_core_vnic_attachments" "bastion1_primaryvnic_attach" {
  count = var.numberOfBastions
  availability_domain = lookup(data.oci_identity_availability_domains.ADs.availability_domains[0], "name")
  compartment_id = var.compartment_ocid
  instance_id         = oci_core_instance.bastion1[count.index].id
}

data "oci_core_vnic" "bastion1_primaryvnic" {
  count = var.numberOfBastions
  vnic_id = data.oci_core_vnic_attachments.bastion1_primaryvnic_attach[count.index].vnic_attachments.0.vnic_id
}

# output "bastion1_PublicIP" {
#   value = [data.oci_core_vnic.bastion1_primaryvnic[count.index].public_ip_address]
# }