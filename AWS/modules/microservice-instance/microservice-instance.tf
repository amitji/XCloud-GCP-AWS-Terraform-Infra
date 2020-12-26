resource "random_id" "app_name_suffix" {
  byte_length = 4
}

resource "aws_instance" "apps" {

  for_each = toset(var.zones )
  availability_zone = each.key
  ami = var.image
  instance_type = var.instance_type
  tags = {  
    Name = "apps-${random_id.app_name_suffix.hex}"
  }

  # network_interface {
  #   network_interface_id = var.primary_network_interface-id
  #   device_index         = 0
  # }
  
}


