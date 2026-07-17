variable "vpc_cidr_block" {
  type    = string
  default = "10.0.0.0/16"
}

variable "vpc_name" {
  type    = string
  default = "dev-vpc"
}

variable "subnet_cidr_block" {
  type    = string
  default = "10.0.1.0/24"
}

variable "subnet_name" {
  type    = string
  default = "dev-public-subnet"
}

variable "bucket_name" {
  type    = string
  default = "kanavenaaa-terraform-bucket-20260717"
}

variable "environment" {
  type    = string
  default = "dev"
}
