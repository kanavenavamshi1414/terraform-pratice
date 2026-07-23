terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
    }
  }
}

# IAM User 1
# Region: eu-north-1
provider "aws" {
  region  = var.europe_region
  profile = var.europe_profile
}

# IAM User 2
# Region: us-east-1
provider "aws" {
  alias   = "us_east"
  region  = var.us_region
  profile = var.us_profile
}