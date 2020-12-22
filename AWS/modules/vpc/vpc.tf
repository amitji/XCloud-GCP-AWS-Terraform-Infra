resource "aws_vpc" "xcloud-vpc" {
  cidr_block       = "10.0.0.0/16"
  enable_dns_hostnames = true

  tags = {
    Name = "xcloud-vpc"
  }
}

resource "aws_subnet" "public_subnet" {
  vpc_id     = aws_vpc.xcloud-vpc.id
  cidr_block = "10.0.0.0/24"
  for_each = toset(var.zones)
  availability_zone = each.key

  tags = {
    Name = each.key
  }
}

resource "aws_security_group" "allow_http" {
  name        = "xcloud-sg-allow-http"
  description = "Allow HTTP & ICMP inbound connections"
  vpc_id = aws_vpc.xcloud-vpc.id
  
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





