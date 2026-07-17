variable "cidr_block" {
    description = "The CIDR block for the VPC"
    type = string
    default = ""
}

variable "tag" {
    description = "the tag for the vpc"
    type = string
    default = ""
}

 variable "subnet_cidr_block" {
    description = " the cidr block for the subnety"
    type = string
    default = ""
 }

 variable "subnet_tag" {
    description = "the tag for the subnet"
    type = string
    default = ""
 }