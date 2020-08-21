# ATP Rules
resource "oci_core_network_security_group" "ATPSecurityGroup" {
    compartment_id = var.compartment_ocid
    vcn_id = oci_core_vcn.vcn01.id
    display_name = "DB_NSG"
}

resource "oci_core_network_security_group_security_rule" "ATPSecurityIngressGroupRules1521TCP" {
    network_security_group_id = oci_core_network_security_group.ATPSecurityGroup.id
    direction = "INGRESS"
    protocol = "6"
    source = oci_core_network_security_group.APPSecurityGroup.id
    source_type = "NETWORK_SECURITY_GROUP"
    tcp_options {
        destination_port_range {
            max = 1522
            min = 1521
        }
    }
}

resource "oci_core_network_security_group_security_rule" "ATPSecurityIngressGroupRulesBastion" {
    network_security_group_id = oci_core_network_security_group.ATPSecurityGroup.id
    direction = "INGRESS"
    protocol = "all"
    source = oci_core_network_security_group.BastionSecurityGroup.id
    source_type = "NETWORK_SECURITY_GROUP"
}

# LB Rules
resource "oci_core_network_security_group" "LBSecurityGroup" {
    compartment_id = var.compartment_ocid
    vcn_id = oci_core_vcn.vcn01.id
    display_name = "LB_NSG"
}

resource "oci_core_network_security_group_security_rule" "LBSecurityIngressGroupRules80TCP" {
    network_security_group_id = oci_core_network_security_group.LBSecurityGroup.id
    direction = "INGRESS"
    protocol = "6"
    source = "0.0.0.0/0"
    source_type = "CIDR_BLOCK"
    tcp_options {
        destination_port_range {
            max = 80
            min = 80
        }
    }
}

resource "oci_core_network_security_group_security_rule" "LBSecurityIngressGroupRules443TCP" {
    network_security_group_id = oci_core_network_security_group.LBSecurityGroup.id
    direction = "INGRESS"
    protocol = "6"
    source = "0.0.0.0/0"
    source_type = "CIDR_BLOCK"
    tcp_options {
        destination_port_range {
            max = 443
            min = 443
        }
    }
}

# APP
resource "oci_core_network_security_group" "APPSecurityGroup" {
    compartment_id = var.compartment_ocid
    vcn_id = oci_core_vcn.vcn01.id
    display_name = "APP_NSG"
}

resource "oci_core_network_security_group_security_rule" "APPSecurityIngressGroupRules9050TCP" {
    network_security_group_id = oci_core_network_security_group.APPSecurityGroup.id
    direction = "INGRESS"
    protocol = "6"
    source = oci_core_network_security_group.LBSecurityGroup.id
    source_type = "NETWORK_SECURITY_GROUP"
    tcp_options {
        destination_port_range {
            max = 9090
            min = 9050
        }
    }
}

resource "oci_core_network_security_group_security_rule" "APPSecurityIngressGroupRulesBastion" {
    network_security_group_id = oci_core_network_security_group.APPSecurityGroup.id
    direction = "INGRESS"
    protocol = "all"
    source = oci_core_network_security_group.BastionSecurityGroup.id
    source_type = "NETWORK_SECURITY_GROUP"
}


# Bastion
resource "oci_core_network_security_group" "BastionSecurityGroup" {
    compartment_id = var.compartment_ocid
    vcn_id = oci_core_vcn.vcn01.id
    display_name = "BASTION_NSG"
}

resource "oci_core_network_security_group_security_rule" "BastionSecurityIngressGroupRules22TCP" {
    network_security_group_id = oci_core_network_security_group.BastionSecurityGroup.id
    direction = "INGRESS"
    protocol = "6"
    source = "0.0.0.0/0"
    source_type = "CIDR_BLOCK"
    tcp_options {
        destination_port_range {
            max = 22
            min = 22
        }
    }
}

#FSS 
resource "oci_core_network_security_group" "FSSSecurityGroup" {
    compartment_id = var.compartment_ocid
    vcn_id = oci_core_vcn.vcn01.id
    display_name = "FSS_NSG"
}

resource "oci_core_network_security_group_security_rule" "FSSSecurityIngressGroupRules22TCP" {
    network_security_group_id = oci_core_network_security_group.FSSSecurityGroup.id
    direction = "INGRESS"
    protocol = "all"
    source = "0.0.0.0/0"
    source_type = "CIDR_BLOCK"
    # tcp_options {
    #     destination_port_range {
    #         max = 22
    #         min = 22
    #     }
    # }
}