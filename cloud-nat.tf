##################################################################################
##         Create a simple Cloud NAT and router to allow internet access        ##
##################################################################################

resource "random_string" "name_suffix" {
  length  = 6
  upper   = false
  special = false
}


resource "google_compute_router" "router" {
  name    = "cloud-router-${var.region}"
  project = var.project_id
  region  = var.region
  network = google_compute_network.vpc_network.name
  bgp {
    asn                = 64514
    keepalive_interval = 20
  }
}

resource "google_compute_router_nat" "main" {
  project                             = var.project_id
  region                              = var.region
  name                                = "cloud-nat-${var.region}"
  router                              = google_compute_router.router.name
  nat_ip_allocate_option              = "AUTO_ONLY"
  nat_ips                             = []
  source_subnetwork_ip_ranges_to_nat  = "ALL_SUBNETWORKS_ALL_IP_RANGES"
  min_ports_per_vm                    = 64
  udp_idle_timeout_sec                = 30
  icmp_idle_timeout_sec               = 30
  tcp_established_idle_timeout_sec    = 1200
  tcp_transitory_idle_timeout_sec     = 30
  enable_endpoint_independent_mapping = null

}