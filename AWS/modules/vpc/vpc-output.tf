# output "sg-allow-http" {
#   # value = var.enable_autoscaling ? "${google_compute_instance_template.webserver[0].self_link}" : ""
#   value = aws_security_group.allow_http
# }
output "vpc-id" {
  # value = var.enable_autoscaling ? "${google_compute_instance_template.webserver[0].self_link}" : ""
  value = aws_vpc.xcloud-vpc.id
}

# output "primary_network_interface-id" {
#   value = aws_network_interface.primary_network_interface.id
# }