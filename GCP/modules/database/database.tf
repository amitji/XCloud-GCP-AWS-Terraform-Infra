resource "random_id" "db_name_suffix" {
  byte_length = 4
}

resource "google_sql_database_instance" "postgres" {
  name             = "postgres-instance-${random_id.db_name_suffix.hex}"
  database_version = "POSTGRES_11"
  settings {
    tier = "db-f1-micro"

    ip_configuration {
      
        # authorized_networks {
        #   value           = "0.0.0.0/0"
        #   name            = "all"
        # }
      dynamic "authorized_networks" {
        for_each = var.nat_ip
        iterator = ip
        content {
          # value = each.key
          value = ip.value
        }
      }

      # dynamic "authorized_networks" {
      #   for_each = locals.onprem
      #   iterator = onprem
      #   content {
      #     name  = "onprem-${onprem.key}"
      #     value = onprem.value
      #   }
      # }
    }
  }
}
locals {
  # onprem = ["192.168.1.2", "192.168.2.3"]
}