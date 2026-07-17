variable "aws_region" {
  description = "AWS Region"
  type        = string
  default     = "eu-north-1"
}

# variable for vpc

variable "vpc_cidr" {
    description = "vpc-cidr block"
    type = string
    default = "10.0.0.0/16"
}

# variable for public subnet

variable "public_subnet_cidr" {
  description = "this cidr belongs to public subnet"
  type = string
  default = "10.0.1.0/24"
}

# variable for private subnet

variable "private_subnet_cidr" {
    description = "this cidr block belongs to private subnet"
    type = string 
    default = "10.0.2.0/24"
}

# ec2

variable "instance_type" {
    description = "this instance tpe is belongs to both public and private instances"
    type = string
    default = "t3.micro"
}

variable "key_name" {
  description = "EC2 Key Pair Name"
  type        = string
  default     = "devloadbal"
}

variable "ami_id" {
  description = "this ami is also for both instances"
  type        = string
  default     = "ami-0c1bed477f4225f83"
}

# Tags

variable "vpc_name" {
  description = "VPC Name"
  type        = string
  default     = "main-vpc"
}

variable "public_subnet_name" {
  description = "Public Subnet Name"
  type        = string
  default     = "main-public-subnet"
}

variable "private_subnet_name" {
  description = "Private Subnet Name"
  type        = string
  default     = "main-private-subnet"
}

variable "security_group_name" {
  description = "Security Group Name"
  type        = string
  default     = "main-security-group"
}

variable "internet_gateway_name" {
  description = "Internet Gateway Name"
  type        = string
  default     = "main-igw"
}

variable "public_route_table_name" {
  description = "Public Route Table Name"
  type        = string
  default     = "main-public-rt"
}

variable "private_route_table_name" {
  description = "Private Route Table Name"
  type        = string
  default     = "main-private-rt"
}

variable "nat_gateway_name" {
  description = "NAT Gateway Name"
  type        = string
  default     = "main-nat"
}

variable "public_instance_name" {
  description = "Public EC2 Name"
  type        = string
  default     = "Public-EC2"
}

variable "private_instance_name" {
  description = "Private EC2 Name"
  type        = string
  default     = "Private-EC2"
}