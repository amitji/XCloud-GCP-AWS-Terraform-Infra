
resource "aws_launch_configuration" "webserver" {
  name_prefix = "webserver-"

  image_id = var.image
  instance_type = var.instance_type
  # key_name = "Lenovo T410"

  security_groups = [aws_security_group.allow_http.name]
  # security_groups = [ module.vpc.sg-allow-http.id ]


  associate_public_ip_address = true

  user_data = <<USER_DATA
#!/bin/bash
yum update
yum -y install nginx
echo "$(curl http://169.254.169.254/latest/meta-data/local-ipv4)" > /usr/share/nginx/html/index.html
chkconfig nginx on
service nginx start
  USER_DATA

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_security_group" "allow_http" {
  name        = "xcloud-sg-allow-http"
  description = "Allow HTTP & ICMP inbound connections"
  vpc_id = var.vpc-id
  # vpc_id = module.vpc.vpc-id
  
  
  ingress {
    from_port   = -1
    to_port     = -1
    protocol    = "icmp"
  }
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
  }

  tags = {
    Name = "Allow HTTP, ICMP Security Group"
  }
}


# module "vpc" {
#   count = var.create_default_vpc ? 1:0
#   source = "../vpc"
#   region = var.region
#   zones = var.zones
# }









