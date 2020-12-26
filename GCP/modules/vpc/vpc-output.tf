# output "sg-allow-http" {
#   # value = var.enable_autoscaling ? "${google_compute_instance_template.webserver[0].self_link}" : ""
#   value = aws_security_group.allow_http
# }
output "vpc-name" {
  # value = var.enable_autoscaling ? "${google_compute_instance_template.webserver[0].self_link}" : ""
  value = google_compute_network.xcloud-vpc.name
}
output "subnet-self_link" {
  # value = var.enable_autoscaling ? "${google_compute_instance_template.webserver[0].self_link}" : ""
  value = google_compute_subnetwork.xcloud-subnet.self_link
}

