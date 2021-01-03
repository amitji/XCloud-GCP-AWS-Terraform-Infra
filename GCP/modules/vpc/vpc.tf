resource "google_compute_network" "xcloud-vpc" {
  name = "xcloud-vpc"
  auto_create_subnetworks = "false"
}

resource "google_compute_subnetwork" "xcloud-subnet" {
 name          = "${var.name}-subnet"
 ip_cidr_range = "10.0.0.0/24"
 network       = google_compute_network.xcloud-vpc.id
#  depends_on    = ["google_compute_network.xcloud-vpc"]
 region      = "${var.region}"
}

resource "google_compute_firewall" "xcloud-vpc-firewall" {
  name    = "xcloud-firewall"
  network = google_compute_network.xcloud-vpc.id

  allow {
    protocol = "icmp"
  }
  allow {
    protocol = "tcp"
    ports    = ["80", "8080", "1000-2000"]
  }
  source_tags = ["web"]
}

