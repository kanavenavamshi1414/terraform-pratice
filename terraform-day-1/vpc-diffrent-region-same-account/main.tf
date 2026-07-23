# ==================================
# VPC 1 - eu-north-1
# ==================================

resource "aws_vpc" "ap_vpc" {
  provider = aws

  cidr_block           = var.ap_vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "ap-VPC"
  }
}


# ==================================
# VPC 2 - us-east-1
# ==================================

resource "aws_vpc" "us_vpc" {
  provider = aws.us_east

  cidr_block           = var.us_vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "US-VPC"
  }
}