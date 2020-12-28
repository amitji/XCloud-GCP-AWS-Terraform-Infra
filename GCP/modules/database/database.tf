resource "random_id" "db_name_suffix" {
  byte_length = 4
}

resource "google_sql_database_instance" "postgres_db" {
  name             = "postgres-instance-${random_id.db_name_suffix.hex}"
  database_version = "POSTGRES_11"
  deletion_protection = false
  settings {
    tier = "db-f1-micro"

    ip_configuration {
      
        authorized_networks {
          value           = "0.0.0.0/0"
          name            = "all"
        }

    }
  }
}
resource "google_sql_user" "users" {
  name     = var.db_user
  instance = google_sql_database_instance.postgres_db.name
  password = var.db_password
  

}