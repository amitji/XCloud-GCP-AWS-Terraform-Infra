variable "name" {default="xcloud-project"}
# variable "project" {default = ""}
# variable "zones" { default = ["europe-west3-a", "europe-west3-b"] }
variable "region" {default = "eu-west-1"}
variable "zones" { default = ["eu-west-1a", "eu-west-1b"] }
variable "env" { default = "dev" }
variable "network_name" {default = "xcloud network"}
variable "image" {default="ami-0947d2ba12ee1ff75"}

variable "appserver_count" { default = 0 }
# variable "app_image" { default = "centos-7-v20170918" }
variable "instance_type" { default = "t2.micro" }
variable "no_of_db_instances"{ default = 0 }
variable "create_default_vpc"{ default = true }
variable "enable_autoscaling" {default = false}