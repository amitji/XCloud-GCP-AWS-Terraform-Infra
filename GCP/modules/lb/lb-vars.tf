variable "name" {}
variable "project" {}
variable "region" {}
# variable "env" { default = "dev" }
# variable "instance_type" {default = "f1-micro"}
variable "lb_count" {default = 2 }
variable "instance_template" {}
variable "zones" { type = "list" }
