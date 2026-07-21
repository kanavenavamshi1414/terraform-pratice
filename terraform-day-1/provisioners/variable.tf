variable "aws_region" {
    description = "The AWS region to create resources in"
    type =string
    default = "eu-north-1"
}

variable "instance_type" {
    description = "The type of instance to create"
    type = string
    default = "t3.micro"
}

variable "instance_count" {
    description = "The number of instances to create"
    type = number
    default = 1
}

variable "instance_name" {
    description = "The name of the instance"
    type = string
    default = "dev-frontend"
}

variable "key_name"{
    description = "The name of the key pair to use for the instance"
    type = string
    default = "alpkey"
}

variable "subnet_cidr_block" {
    description = "The CIDR block for the subnet"
    type = string
    default = "10.0.1.0/24"
}
variable "subnet_tag" {
    description = "The tag for the subnet"
    type = string
    default = "dev-frontend"
}
# VPC variales

variable "vpc_cidr_block" {
    description = "The CIDR block for the VPC"
    type = string
    default = "10.0.0.0/16"
}

variable "vpc_tag" {
    description = "the tag for the vpc"
    type =string
    default = "dev-vpc"
}

# Variables for route table and internet gateway

variable "route_table_tag" {
    description = "the tag for the route table"
    type = string 
    default = "dev-public-rt"
}

variable "internet_gateway_tag" {
    description = "the tag for the internet gateway"
    type = string
    default = "dev-igw"
}

# Variables for security group

variable "security_group_name" {
    description = "the name of the security group"
    type = string
    default = "dev-sg"
}
