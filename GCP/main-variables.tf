variable "name" {default="xcloud-project"}
variable "project" {default = ""}
variable "region" {default = "eu-west2"}
variable "zones" { default = ["europe-west2-a", "europe-west2-b"] }
variable "env" { default = "dev" }
variable "network_name" {default = "xcloud network"}
variable "source_image" {default="ubuntu-os-cloud/ubuntu-1804-lts"}

variable "appserver_count" { default = 2 }
variable "webserver_count" { default = 2 }
variable "app_image" { default = "centos-7-v20170918" }
variable "app_instance_type" { default = "f1-micro" }
variable "no_of_db_instances"{ default = 1 }
variable "create_default_vpc"{ default = true }
variable "enable_autoscaling" {default = true}