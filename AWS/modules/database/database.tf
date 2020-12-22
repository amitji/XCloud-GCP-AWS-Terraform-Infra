resource "random_id" "db_name_suffix" {
  byte_length = 4
}
resource "aws_db_instance" "default" {
  # count  = var.no_of_db_instances
  name             = "postgres-instance-${random_id.db_name_suffix.hex}"
  allocated_storage    = 2
  storage_type         = "gp2"
  engine               = "postgres"
  engine_version       = "12.4"
  instance_class       = "db.t2.micro"
  username             = var.db_user
  password             = var.db_password
}
