resource "random_id" "app_name_suffix" {
  byte_length = 4
}

resource "google_compute_instance" "apps" {
  name         = "apps-${random_id.app_name_suffix.hex}"
  machine_type = var.instance_type
  for_each = toset(var.zones )
  zone = each.key

  boot_disk {
    initialize_params {
      image = var.image
    }
  }

  network_interface {
    # network = "default"
    # network = "google_compute_network.xcloud-vpc.self_link" 
    network = var.vpc-name
    subnetwork = var.subnet-self_link

    access_config {
      // Ephemeral IP
    }
  }
}
