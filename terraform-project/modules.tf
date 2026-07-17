module "infrastructure" {
  source = "../terraform-modules"

  vpc_cidr_block    = var.vpc_cidr_block
  vpc_name          = var.vpc_name
  subnet_cidr_block = var.subnet_cidr_block
  subnet_name       = var.subnet_name
  bucket_name       = var.bucket_name
  environment       = var.environment
}