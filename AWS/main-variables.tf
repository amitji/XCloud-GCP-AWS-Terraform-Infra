variable name {}
variable region {default = "eu-west-2"}
variable zones { default = ["eu-west-2a", "eu-west-2b"] }
variable env { default = "dev" }
variable network_name {default = "xcloud network"}
variable credentials{}
variable image {default="ami-0e80a462ede03e653"} 

variable appserver_count { default = 2 }
variable instance_type { default = "t2.micro" }
variable no_of_db_instances{ default = 1 }
variable create_default_vpc{ default = true }
variable enable_autoscaling {default = true}
variable db_name {}
variable db_user {}
variable db_password {}