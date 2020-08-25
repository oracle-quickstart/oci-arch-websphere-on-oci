## Copyright © 2020, Oracle and/or its affiliates. 
## All rights reserved. The Universal Permissive License (UPL), Version 1.0 as shown at http://oss.oracle.com/licenses/upl

resource "oci_load_balancer" "lb01" {
  shape          = "100Mbps"
  compartment_id = var.compartment_ocid

  subnet_ids = [
    oci_core_subnet.vcn01_subnet_pub01.id,
  ]

  network_security_group_ids = [oci_core_network_security_group.LBSecurityGroup.id]
  
  display_name = "load_balancer_01"
}

resource "oci_load_balancer_backend_set" "lb_be_app01" {
  name             = "lb_app01"
  load_balancer_id = oci_load_balancer.lb01.id
  policy           = "ROUND_ROBIN"
  
  # If you want to swithc the algorithm
  # policy           = "LEAST_CONNECTIONS"
  # or
  # policy           = "FAIL-OVER"

  health_checker {
    port                = "9050"
    protocol            = "TCP"
    # response_body_regex = ".*"
    # url_path            = "/"
    interval_ms         = "10000"
    # return_code         = "200"
    timeout_in_millis   = "3000"
    retries             = "3"
  }
}

resource "oci_load_balancer_listener" "lb_listener_app01" {
  load_balancer_id         = oci_load_balancer.lb01.id
  name                     = "http"
  default_backend_set_name = oci_load_balancer_backend_set.lb_be_app01.name
  port                     = 80
  protocol                 = "HTTP"
}

# Different backends might be necessary. Replicate this section to deploy multiple backends
# adjusting to the ports used.

resource "oci_load_balancer_backend" "lb_be_appserver1" {
  count = var.numberOfNodes
  load_balancer_id = oci_load_balancer.lb01.id
  backendset_name  = oci_load_balancer_backend_set.lb_be_app01.name
  ip_address       = oci_core_instance.webserver1[count.index].private_ip
  port             = 9050
  backup           = false
  drain            = false
  offline          = false
  weight           = 1
}

