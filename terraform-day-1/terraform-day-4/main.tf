# Vpc resource

resource "aws_vpc" "main" {
cidr_block = var.vpc_cidr_block
tags = {
  Name = var.vpc_tag
}

}

# Subnet resource

resource "aws_subnet" "public_1" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = true

  tags = {
    Name = "public-subnet-1"
  }
}

resource "aws_subnet" "public_2" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.2.0/24"
  map_public_ip_on_launch = true

  tags = {
    Name = "public-subnet-2"
  }
}
# Security group resource

resource "aws_security_group" "main" {
    name = var.security_group_name
    description = "this security group is for test instance"
    vpc_id = aws_vpc.main.id

    ingress {
        from_port = 22
        to_port =22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    ingress {
        from_port = 443
        to_port = 443
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    ingress {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        security_groups = [aws_security_group.lb_sg.id]
    }

    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
}

# Internet gateway resource

resource "aws_internet_gateway" "igw" {
    vpc_id = aws_vpc.main.id

    tags = {
        Name = var.internet_gateway_tag
    }
}

# Route table resource

resource "aws_route_table" "public_rt" {
    vpc_id = aws_vpc.main.id

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.igw.id
    }

    tags = {
        Name = "test-public-rt"
    }
}

# Route table association resource

resource "aws_route_table_association" "public_assoc_1" {
  subnet_id      = aws_subnet.public_1.id
  route_table_id = aws_route_table.public_rt.id
}

resource "aws_route_table_association" "public_assoc_2" {
  subnet_id      = aws_subnet.public_2.id
  route_table_id = aws_route_table.public_rt.id
}

# EC2 instance resource

resource "aws_instance" "web" {
    ami = "ami-0c1bed477f4225f83"
    instance_type ="t3-micro"
    subnet_id = aws_subnet.public_1.id
    vpc_security_group_ids = [aws_security_group.main.id]
    key_name ="devloadbal"
}

# Load balancer resource
 
resource "aws_security_group" "lb_sg" {
    name = "lb-sg"
    description = "Security group for load balancer"
    vpc_id = aws_vpc.main.id

    ingress {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    ingress {
        from_port = 443
        to_port = 443
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    egress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }

}

 resource "aws_lb" "test_lb" {
    name = "test-lb"
    internal = false
    load_balancer_type = "application"
    security_groups = [aws_security_group.lb_sg.id]
    subnets = [aws_subnet.public_1.id, aws_subnet.public_2.id] 

    tags = {
        Name = "test-lb"
    }
 }

resource "aws_lb_listener" "test_listener" {
    load_balancer_arn = aws_lb.test_lb.arn
    port = 80
    protocol = "HTTP"

    default_action {
        type = "forward"
        target_group_arn = aws_lb_target_group.test_tg.arn
    }
}

resource "aws_lb_listener" "test_listener_https" {
  load_balancer_arn = aws_lb.test_lb.arn
  port              = 443
  protocol          = "HTTPS"

  certificate_arn = "arn:aws:acm:eu-north-1:364410975057:certificate/ed151dc7-0c08-4d21-9350-fc07c040dc6f"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.test_tg.arn
  }
}

resource "aws_lb_listener_rule" "test_listener_rule" {
    listener_arn = aws_lb_listener.test_listener.arn
    priority = 100

    action {
        type = "forward"
        target_group_arn = aws_lb_target_group.test_tg.arn
    }

    condition {
        host_header {
            values = ["kanavena.shop"]
        }
    }
}
# Target group resource

resource "aws_lb_target_group" "test_tg" {
  name     = "test-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.main.id

  health_check {
    protocol            = "HTTP"
    path                = "/"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
    matcher             = "200-299"
  }

  tags = {
    Name = "test-tg"
  }
}

resource "aws_lb_target_group_attachment" "test_tg_attachment" {
  target_group_arn = aws_lb_target_group.test_tg.arn
  target_id        = aws_instance.web.id
  port             = 80
}