provider "google" {
  credentials = "${file("${var.credentials}")}"
  project = var.project
  region =var.region
  
}

# Include modules

#create a postgres sql database
module "database" {
  count  = var.no_of_db_instances
  source = "./modules/database"
  # nat_ip = module.microservice-instance[0].nat_ip[0]
  no_of_db_instances = var.no_of_db_instances
  db_user = var.db_user
  db_password = var.db_password
}

# create load balancer, auto scaling 
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

#create an instance template for webserver for auto scaling
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

# create microservices/apps in each zone
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

#create VPC and subnets
module "vpc" {
  source = "./modules/vpc"
  region = var.region
  name = var.name
}
