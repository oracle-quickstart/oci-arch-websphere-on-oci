## Copyright © 2020, Oracle and/or its affiliates. 
## All rights reserved. The Universal Permissive License (UPL), Version 1.0 as shown at http://oss.oracle.com/licenses/upl

variable "private_key_path" {}
variable "fingerprint" {}
variable "user_ocid" {}


variable "region" {}
variable "tenancy_ocid" {}
variable "compartment_ocid" {}
variable "ssh_public_key" {}
variable "ssh_private_key_path" {}

variable "igw_display_name" {
  default = "internet-gateway"
}

variable "vcn01_cidr_block" {
  default = "10.0.0.0/16"
}
variable "vcn01_dns_label" {
  default = "vcn01"
}
variable "vcn01_display_name" {
  default = "vcn01"
}

variable "vcn01_subnet_bastion01_cidr_block" {
  default = "10.0.0.0/24"
}

variable "vcn01_subnet_bastion01_display_name" {
  default = "vcn01_subnet_bastion01"
}

variable "vcn01_subnet_lb01_cidr_block" {
  default = "10.0.10.0/24"
}

variable "vcn01_subnet_lb01_display_name" {
  default = "vcn01_subnet_pub01"
}

variable "vcn01_subnet_app01_cidr_block" {
  default = "10.0.20.0/24"
}

variable "vcn01_subnet_app01_display_name" {
  default = "vcn01_subnet_app01"
}

variable "vcn01_subnet_db01_cidr_block" {
  default = "10.0.30.0/24"
}

variable "vcn01_subnet_db01_display_name" {
  default = "vcn01_subnet_db01"
}

variable "use_existing_network" {
  type = bool
  default = false
}

# OS Images
variable "instance_os" {
  description = "Operating system for compute instances"
  default     = "Oracle Linux"
}

variable "linux_os_version" {
  description = "Operating system version for all Linux instances"
  default     = "7.8"
}

variable "InstanceShape" {
    default = "VM.Standard2.1"
}

variable "OsImage" {
   default = "Oracle-Linux-7.8-2020.05.26-0"
}
variable "ATP_tde_wallet_zip_file" {default = "tde_wallet_ATPdb1.zip"}

variable "numberOfNodes" {default = 1}

variable "atp_password" {}
variable "atp_db_name" {}
variable "atp_name" {} 

variable "file_system_display_name" {}
variable "mount_target_hostname_label" {}
variable "export_path" {}