# resource "random_id" "app_name_suffix" {
#   byte_length = 4
# }

resource "google_compute_instance" "apps" {
  count        = var.appserver_count
  name         = "apps-${count.index + 1}"
  # name         = "apps-${random_id.app_name_suffix.hex}"
  machine_type = "f1-micro"

  boot_disk {
    initialize_params {
      image = "ubuntu-os-cloud/ubuntu-1804-lts"
    }
  }

  network_interface {
    network = "default"

    access_config {
      // Ephemeral IP
    }
  }
}
