# data "aws_availability_zones" "available" {}

resource "aws_vpc" "xcloud-vpc" {
  cidr_block       = "10.0.0.0/16"
  enable_dns_hostnames = true

  tags = {
    Name = "xcloud-vpc"
  }
}

resource "aws_subnet" "public_subnet" {
  vpc_id     = aws_vpc.xcloud-vpc.id

  # availability_zone = var.zones[0]
  count = "${length(var.zones)}"
  availability_zone = "${var.zones[count.index]}"
  cidr_block = "10.0.${10+count.index}.0/24"
  tags = {
    Name = var.zones[count.index]
  }
}

