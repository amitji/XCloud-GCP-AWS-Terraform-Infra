provider "aws" {
  # credentials = "${file("../../service-account.json")}"
  shared_credentials_file = "~/.aws/credentials"
  # project = var.project
  region =var.region
  
}

# Include modules
module "microservice-instance" {
  count = var.appserver_count
  source = "./modules/microservice-instance"
  appserver_count = var.appserver_count
}

module "database" {
  count  = var.no_of_db_instances
  source = "./modules/database"
  # nat_ip = module.microservice-instance.nat_ip
  no_of_db_instances = var.no_of_db_instances
}

module "vpc" {
  count = var.create_default_vpc ? 1:0
  source = "./modules/vpc"
  region = var.region
  zones = var.zones
}

module "lb" {
  count   = var.enable_autoscaling ? 1:0
  source  = "./modules/lb"
  image = var.image
  instance_type = var.instance_type
  sg-allow-http = module.vpc[0].sg-allow-http
  # vpc-id = module.vpc[0].vpc-id
}
