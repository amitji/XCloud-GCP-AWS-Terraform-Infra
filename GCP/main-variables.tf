variable "name" {default="xcloud-project"}
variable "project" {}
variable "region" {default = "eu-west1"}
variable "zones" { default = ["europe-west3-a", "europe-west3-b"] }
variable "env" { default = "dev" }
variable "network_name" {default = "xcloud network"}
variable "source_image" {default="ubuntu-os-cloud/ubuntu-1804-lts"}

variable "appserver_count" { default = 1 }
variable "app_image" { default = "centos-7-v20170918" }
variable "app_instance_type" { default = "f1-micro" }
variable "no_of_db_instances"{ default = 0 }
variable "create_default_vpc"{ default = false }
variable "enable_autoscaling" {default = false}