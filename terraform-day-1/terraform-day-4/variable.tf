# Variables for AWS resources
variable "aws_region" {
  description = "The AWS region to deploy resources"
  default     = "eu-north-1"
  type        = string
}

# Variable for VPC

variable "vpc_cidr_block" {
  description = "this cidr block is for vpc"
  default     = "10.0.0.0/16"
  type        = string
}

variable "vpc_tag" {
    description = "this tag is for this vpc"
    default = "test-vpc"
    type = string
}

# Variable for Subnet

variable "public_subnet_1_cidr" {
  default = "10.0.1.0/24"
  type    = string

}

variable "public_subnet_2_cidr" {
  default = "10.0.2.0/24"
  type    = string

}

variable "public_subnet_1_tag" {
  type    = string
  default = "test-subnet-1a"
}

variable "public_subnet_2_tag" {
  type    = string
  default = "test-subnet-1b"
}
# Variable for Security Group 

variable "security_group_name" {
    description = "this name is belongs to this security group only"
    default = "test-sg"
    type = string
}

# Variable for Instance

variable "instance_type" {
    description = "this is the type of instance"
    default = "t3.micro"
    type = string
}

variable "key_name" {
    description = "this is the key name for instance"
    default = "devloadbal"
    type = string
}

variable "instance_name" {
    description = "this is the name of instance"
    default = "test-instance"
    type = string
}

variable "ami_id" {
    description = "this is the ami id for instance"
    default = "ami-0c1bed477f4225f83"
    type = string
}

variable "instance_tags" {
    description = "this is the tags for instance"
    default = {
        Name = "test-instance"
    }
    type = map(string)
}

# Variable for Internet Gateway

variable "internet_gateway_tag" {
    description = "this is the tag for internet gateway"
    default = "test-igw"
    type = string
}

# Variable for Route Table

variable "route_table_tag" {
    description = "this is the tag for route table"
    default = "test-public-rt"
    type = string
}

variable "route_table_association_tag" {
    description = "this is the tag for route table association"
    default = "test-public-rt-assoc"
    type = string
}

# Variable for Load Balancer

variable "load_balancer_name" {
    description = "this is the name of the load balancer"
    default = "test-lb"
    type = string
}

variable "load_balancer_tags" {
    description = "this is the tags for load balancer"
    default = {
        Name = "test-lb"
    }
    type = map(string)
}

variable "load_balancer_sg_name" {
    description = "this is the name of the load balancer security group"
    default = "test-lb-sg"
    type = string
}

variable "load_balancer_sg_tags" {
    description = "this is the tags for load balancer security group"
    default = {
        Name = "test-lb-sg"
    }
    type = map(string)
}

# Variable for Load Balancer Listener

variable "load_balancer_listener_port" {
    description = "this is the port for load balancer listener"
    default = 80
    type = number
}

variable "load_balancer_listener_protocol" {
    description = "this is the protocol for load balancer listener"
    default = "HTTP"
    type = string
}

variable "load_balancer_listener_https_port" {
    description = "this is the https port for load balancer listener"
    default = 443
    type = number
}

variable "load_balancer_listener_https_protocol" {
    description = "this is the https protocol for load balancer listener"
    default = "HTTPS"
    type = string
}

# Variable for Load Balancer Target Group

variable "load_balancer_target_group_name" {
    description = "this is the name of the load balancer target group"
    default = "test-tg"
    type = string
}

variable "load_balancer_target_group_tags" {
    description = "this is the tags for load balancer target group"
    default = {
        Name = "test-tg"
    }
    type = map(string)
}

variable "load_balancer_target_group_port" {
    description = "this is the port for load balancer target group"
    default = 80
    type = number
}

variable "load_balancer_target_group_protocol" {
    description = "this is the protocol for load balancer target group"
    default = "HTTP"
    type = string
}
