resource "google_compute_network" "vpc_network" {
  project                 = var.project
  name                    = "${var.project}-network"
  auto_create_subnetworks = false
  mtu                     = 1460
  depends_on = [
    google_project_service.services
  ]
}

resource "google_compute_firewall" "default" {
  name    = "firewall-allow-ssh-http-icmp"
  network = google_compute_network.vpc_network.name

  allow {
    protocol = "icmp"
  }

  allow {
    protocol = "tcp"
    ports    = ["22", "80"]
  }
  source_ranges = ["0.0.0.0/0"]
}

resource "google_compute_router" "router" {
  name    = "my-router"
  region  = var.region
  network = google_compute_network.vpc_network.name

  bgp {
    asn = 64514
  }
}

resource "google_compute_router_nat" "nat" {
  name                               = "my-router-nat"
  router                             = google_compute_router.router.name
  region                             = google_compute_router.router.region
  nat_ip_allocate_option             = "AUTO_ONLY"
  source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES"

  log_config {
    enable = true
    filter = "ERRORS_ONLY"
  }
}

module "subnets" {
  source       = "./module/subnets"
  project_id   = var.project
  network_name = google_compute_network.vpc_network.name
  subnets      = var.subnets
}

