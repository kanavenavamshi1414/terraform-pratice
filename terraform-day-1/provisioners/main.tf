resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "dev-vpc"
  }
}


resource "aws_subnet" "main" {
  vpc_id     = aws_vpc.main.id
  cidr_block = var.subnet_cidr_block

  tags = {
    Name = var.subnet_tag
  }
}


resource "aws_security_group" "main" {
  name        = var.security_group_name
  description = "Security group for dev instances"
  vpc_id      = aws_vpc.main.id

  # HTTP access for Nginx
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # SSH access for Terraform provisioners
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Allow outbound traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}


resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "dev-igw"
  }
}


resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "public-route-table"
  }
}


resource "aws_route_table_association" "public_assoc" {
  subnet_id      = aws_subnet.main.id
  route_table_id = aws_route_table.public_rt.id
}


resource "aws_instance" "web" {
  ami                         = "ami-0c1bed477f4225f83"
  instance_type               = var.instance_type
  subnet_id                   = aws_subnet.main.id
  vpc_security_group_ids     = [aws_security_group.main.id]
  key_name                   = var.key_name
  associate_public_ip_address = true

  tags = {
    Name = var.instance_name
  }


  # SSH connection for provisioners
  connection {
    type        = "ssh"
    user        = "ec2-user"

    private_key = file("C:/Users/kanav/Downloads/alpkey.pem")

    host    = self.public_ip
    timeout = "10m"
  }


  # File provisioner
  provisioner "file" {
    source      = "file10"
    destination = "/home/ec2-user/file10"
  }


  # Remote-exec provisioner
  provisioner "remote-exec" {
    inline = [
      "touch /home/ec2-user/file200",
      "echo 'hello from veera devops cloud nareshit' >> /home/ec2-user/file200"
    ]
  }


  # Local-exec provisioner
  provisioner "local-exec" {
    command = "touch file500"
  }
}



