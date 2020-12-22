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
  source  = "./modules/lb"
  image = var.image
  instance_type = var.instance_type
  # region = var.region
  # zones = var.zones
  sg-allow-http = module.vpc.sg-allow-http
}

/* 
module "lb" {
  count             = var.enable_autoscaling ? 1:0
  source            = "./modules/lb"
  name              = "${var.name}"
  project           = "${var.project}"
  region            = "${var.region}"
  lb_count          = "${var.appserver_count}"
  instance_template = "${module.instance-template.instance_template}"
  zones             = "${var.zones}"
}

module "instance-template" {
  source        = "./modules/instance-template"
  name          = "${var.project}"
  env           = "${var.env}"
  project       = "${var.project}"
  region        = "${var.region}"
  network_name  = "${var.network_name}"
  source_image  = "${var.source_image}"
  app_instance_type = "${var.app_instance_type}"
  enable_autoscaling  = "${var.enable_autoscaling}"
  
}


*/