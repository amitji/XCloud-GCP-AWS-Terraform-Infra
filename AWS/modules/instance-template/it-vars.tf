variable "name" {}
variable "project" {}
variable "network_name" {}
variable "app_instance_type" {}
variable "enable_autoscaling" {}
variable "env" {}
variable "region" {}
variable "source_image" {}
variable "db_name" {default = "my_db"}
variable "db_user" {default = "admin"}
variable "db_password" {default = "admin"}
variable "db_ip" {default = "192.168.1.2"}
