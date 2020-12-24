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


resource "aws_launch_configuration" "webserver-lc" {
  name_prefix = "webserver-"

  image_id = var.image
  instance_type = var.instance_type

  # security_groups = [aws_security_group.allow_http.name]
  # security_groups = module.vpc.sg-allow-http.id
  # security_groups = [var.sg-allow-http.name]


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


resource "aws_security_group" "elb-sg" {
  name        = "elb-sg"
  description = "Allow HTTP traffic through Elastic Load Balancer"
  vpc_id = aws_vpc.xcloud-vpc.id
  # vpc_id = var.vpc-id

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
    Name = "Allow HTTP through ELB Security Group"
  }
}

resource "aws_elb" "webserver_elb" {
  name = "webserver-elb"
  security_groups = [
    aws_security_group.elb-sg.id
  ]
  # count = lenght(aws_subnet.public_subnet)
  for_each = aws_subnet.public_subnet
  subnets = [each.value.id]
  # subnets = [element(aws_subnet.public_subnet, 0), element(aws_subnet.public_subnet, 1)]


  # subnets = [aws_subnet.public_subnet[0].id]

  cross_zone_load_balancing   = true

  health_check {
    healthy_threshold = 2
    unhealthy_threshold = 2
    timeout = 3
    interval = 30
    target = "HTTP:80/"
  }

  listener {
    lb_port = 80
    lb_protocol = "http"
    instance_port = "80"
    instance_protocol = "http"
  }

}



resource "aws_autoscaling_group" "webserver-asg" {
  name = "${aws_launch_configuration.webserver-lc.name}-asg"

  min_size             = 1
  desired_capacity     = 2
  max_size             = 3
  
  health_check_type    = "ELB"
  for_each = aws_elb.webserver_elb
  load_balancers = [ each.value.id
    # aws_elb.webserver_elb.id
  ]

  launch_configuration = aws_launch_configuration.webserver-lc.name

  # enabled_metrics = [
  #   "GroupMinSize",
  #   "GroupMaxSize",
  #   "GroupDesiredCapacity",
  #   "GroupInServiceInstances",
  #   "GroupTotalInstances"
  # ]

  # metrics_granularity = "1Minute"

  # vpc_zone_identifier  = [
  #   aws_subnet.public_us_east_1a.id,
  #   aws_subnet.public_us_east_1b.id
  # ]

  # Required to redeploy without an outage.
  lifecycle {
    create_before_destroy = true
  }

  tag {
    key                 = "Name"
    value               = "webserver-asg"
    propagate_at_launch = true
  }

}




