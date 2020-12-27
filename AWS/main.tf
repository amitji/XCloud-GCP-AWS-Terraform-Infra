provider "aws" {
  shared_credentials_file = "${file("${var.credentials}")}"
  # project = var.project
  region =var.region
  
}

# Include modules
# create microservices/apps in each zone
module "microservice-instance" {
  count = var.appserver_count
  source = "./modules/microservice-instance"
  appserver_count = var.appserver_count
  image = var.image
  instance_type = var.instance_type
  zones = var.zones
}

# create load balancer, auto scaling 
module "lb" {
  count   = var.enable_autoscaling ? 1:0
  source  = "./modules/lb"
  region = var.region
  zones = var.zones
  image = var.image
  instance_type = var.instance_type
  # sg-allow-http = module.vpc[0].sg-allow-http
  vpc-id = module.vpc.vpc-id
}

#create VPC and subnets
module "vpc" {
  # count = var.create_default_vpc ? 1:0
  source = "./modules/vpc"
  region = var.region
  zones = var.zones
  
}

#create a postgres sql database
module "database" {
  count  = var.no_of_db_instances
  source = "./modules/database"
  # nat_ip = module.microservice-instance.nat_ip
  no_of_db_instances = var.no_of_db_instances
  db_name = var.db_name
  db_user = var.db_user
  db_password = var.db_password
}