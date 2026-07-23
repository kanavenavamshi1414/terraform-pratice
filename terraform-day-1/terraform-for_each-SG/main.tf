resource "aws_vpc" "main" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "devops-vpc"
  }
}


resource "aws_security_group" "terraform_sg" {
  name        = "terraform_sg_for_vpc"
  description = "Allow communication between VPC CIDR blocks"
  vpc_id      = aws_vpc.main.id

  dynamic "ingress" {
    for_each = flatten([
      for cidr, ports in var.cidr_port_map : [
        for port in ports : {
          cidr = cidr
          port = port
        }
      ]
    ])

    content {
      description = "Allow TCP ${ingress.value.port} from ${ingress.value.cidr}"

      from_port   = ingress.value.port
      to_port     = ingress.value.port
      protocol    = "tcp"
      cidr_blocks = [ingress.value.cidr]
    }
  }

  egress {
    description = "Allow all outbound traffic"

    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "terraform_dynamic_sg"
  }
}