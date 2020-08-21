## Copyright © 2020, Oracle and/or its affiliates. 
## All rights reserved. The Universal Permissive License (UPL), Version 1.0 as shown at http://oss.oracle.com/licenses/upl

resource "oci_file_storage_file_system" "WS_file_system" {
    availability_domain = data.oci_identity_availability_domains.ADs.availability_domains[0]["name"]
    compartment_id = var.compartment_ocid
    display_name = var.file_system_display_name

}

resource "oci_file_storage_export_set" "WS_export_set" {
    mount_target_id = oci_file_storage_mount_target.WS_mount_target.id

    # #Optional
    # display_name = "${var.export_set_name}"
    # max_fs_stat_bytes = 23843202333
    # max_fs_stat_files = 223442
}


resource "oci_file_storage_export" "WS_export" {
    #Required
    export_set_id = oci_file_storage_export_set.WS_export_set.id
    file_system_id = oci_file_storage_file_system.WS_file_system.id
    path = var.export_path

    # #Optional
    # export_options {
    #     #Required
    #     source = var.export_export_options_source

    #     # #Optional
    #     # access = "${var.export_export_options_access}"
    #     # anonymous_gid = "${var.export_export_options_anonymous_gid}"
    #     # anonymous_uid = "${var.export_export_options_anonymous_uid}"
    #     # identity_squash = "${var.export_export_options_identity_squash}"
    #     # require_privileged_source_port = "${var.export_export_options_require_privileged_source_port}"
    # }
}

resource "oci_file_storage_mount_target" "WS_mount_target" {
    #Required
    availability_domain = data.oci_identity_availability_domains.ADs.availability_domains[0]["name"]
    compartment_id = var.compartment_ocid
    subnet_id = oci_core_subnet.vcn01_subnet_app01.id

    #Optional
    # hostname_label = var.mount_target_hostname_label
    # ip_address = "${var.mount_target_ip_address}"
    nsg_ids = [oci_core_network_security_group.FSSSecurityGroup.id]
}
