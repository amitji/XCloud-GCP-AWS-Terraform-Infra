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






