<<<<<<< HEAD
resource "aws_vpc" "name" {
  cidr_block = var.cidr_block
  tags = {
    Name = var.tag
  }
}

resource "aws_subnet" "name" {
    vpc_id     = aws_vpc.name.id
    cidr_block = var.subnet_cidr_block
    tags ={
        Name = var.subnet_tag
    }
=======
resource "aws_instance" "name" {
  ami           = var.aws_ami
  instance_type = var.instance_type
  key_name      = var.key_name
  subnet_id     = var.subnet_id
  vpc_security_group_ids = [var.security_group_id]
  tags = {
    Name = var.subnet_tag
  }
>>>>>>> 3e01594d4a7ef0d05048ad22eda18b1a833b4ebe
}