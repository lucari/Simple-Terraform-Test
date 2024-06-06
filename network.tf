resource "google_compute_network" "vpc_network" {
    project = var.project_id
    name = var.vpc_id
    auto_create_subnetworks = false

}

resource "google_compute_subnetwork" "subnetwork" {
    project = var.project_id
    name = var.subnet_name
    ip_cidr_range = var.subnet_cidr
    region = var.region
    network = google_compute_network.vpc_network.name
  
}

resource "google_compute_firewall" "allow-healthcheck" {
    project = var.project_id
    name = "allow-healthcheck"
    description = "Allow traffic from the Load Balancer healthcheck networks"
    direction = "INGRESS"
    source_ranges = [ "35.191.0.0/16","130.211.0.0/22", "209.85.152.0/22", "209.85.204.0/22" ]
    target_tags = [ "allow-hc" ]
    network = google_compute_network.vpc_network.name
    priority = 1000
    allow {
        protocol = "tcp"
        ports    = ["80", "8085"]
    }
}


resource "google_compute_firewall" "allow-iap" {
    project = var.project_id
    name = "allow-iap"
    description = "Allows access to the Compute engines through the IA Proxy (web browser)"
    direction = "INGRESS"
    source_ranges = [ "86.24.213.241", "35.235.240.0/20" ]
    target_tags = [ "allow-iap" ]
    network = google_compute_network.vpc_network.name
    priority = 1000
    allow {
        protocol = "tcp"
        ports    = ["22"]
    }
        
}

resource "google_compute_firewall" "allow-internal" {
    project = var.project_id
    name = "allow-internal"
    direction = "INGRESS"
    source_ranges = [ var.subnet_cidr ]
    network = google_compute_network.vpc_network.name
    priority = 1000
    allow {
        protocol = "all"
    }
}


