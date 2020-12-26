provider "google" {
  credentials = "${file("${var.credentials}")}"
  project = var.project
  region =var.region
  
}

# Include modules

module "database" {
  count  = var.no_of_db_instances
  source = "./modules/database"
  # nat_ip = module.microservice-instance[0].nat_ip[0]
  no_of_db_instances = var.no_of_db_instances
}

module "lb" {
  count             = var.enable_autoscaling ? 1:0
  source            = "./modules/lb"
  name              = var.name
  project           = var.project
  region            = var.region
  webserver_count   = var.webserver_count
  ws-instance_template = module.instance-template.ws-instance_template
  zones             = var.zones
}

# Amit NOT Valid comment - module instance-template Not neeeded since webserver instances are being created in lb module...
module "instance-template" {
  source        = "./modules/instance-template"
  name          = var.project
  env           = var.env
  project       = var.project
  region        = var.region
  vpc-name  = module.vpc.vpc-name
  image  = var.image
  instance_type = var.instance_type
  subnet-self_link = module.vpc.subnet-self_link
  enable_autoscaling  = var.enable_autoscaling
}

#### tested , works fine
module "microservice-instance" {
  count = var.appserver_count
  source = "./modules/microservice-instance"
  appserver_count = var.appserver_count
  image = var.image
  instance_type = var.instance_type
  zones = var.zones
  vpc-name = module.vpc.vpc-name
  subnet-self_link = module.vpc.subnet-self_link
}
module "vpc" {
  # count = var.create_default_vpc ? 1:0
  source = "./modules/vpc"
  region = var.region
  name = var.name
}

