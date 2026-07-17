variable "aws_region" {
  description = "eu-north-1"
  type        = string
}

variable "aws_ami" {
    description = "AMI ID for the EC2 instance"
    type        = string
    default     = "ami-0c1bed477f4225f83"
}

variable "instance_type" {
    description = "Type of EC2 instance"
    type        = string
    default     = "t3.micro"
}

variable "key_name" {
    description = "Name of the key pair to use for the instance"
    type        = string
    default     = "devloadbal"
}

variable "subnet_id" {
    description = "Id of the subnet where the instance will be launched"
    type =string
    default = "subnet-025bb5de19502aada"
}

variable "security_group_id"{
    description = "ID of the security group"
    type = string
    default = "sg-0d0a02619ae600a92"
}

variable "subnet_tag" {
    description = "The tag for the subnet"
    type = string
    default = "dev-frontend"
} 
