variable "europe_region" {
  type    = string
  default = "eu-north-1"
}

variable "us_region" {
  type    = string
  default = "us-east-1"
}

variable "europe_profile" {
  type    = string
  default = "europe-user"
}

variable "us_profile" {
  type    = string
  default = "us-user"
}

variable "europe_vpc_cidr" {
  type    = string
  default = "10.0.0.0/16"
}

variable "us_vpc_cidr" {
  type    = string
  default = "10.1.0.0/16"
}