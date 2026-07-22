# =========================================================
# VPC
# =========================================================

resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr_block

  tags = {
    Name = var.vpc_tag
  }
}


# =========================================================
# PUBLIC SUBNETS
# =========================================================

resource "aws_subnet" "public_1" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "eu-north-1a"
  map_public_ip_on_launch = true

  tags = {
    Name = "public-subnet-1"
  }
}

resource "aws_subnet" "public_2" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.2.0/24"
  availability_zone       = "eu-north-1b"
  map_public_ip_on_launch = true

  tags = {
    Name = "public-subnet-2"
  }
}


# =========================================================
# PRIVATE SUBNETS
# =========================================================

resource "aws_subnet" "private_1" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.3.0/24"
  availability_zone       = "eu-north-1a"
  map_public_ip_on_launch = false

  tags = {
    Name = "private-subnet-1"
  }
}

resource "aws_subnet" "private_2" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.4.0/24"
  availability_zone       = "eu-north-1b"
  map_public_ip_on_launch = false

  tags = {
    Name = "private-subnet-2"
  }
}


# =========================================================
# PUBLIC SECURITY GROUP
# =========================================================

resource "aws_security_group" "public_sg" {
  name        = "public-sg"
  description = "Security group for public EC2"
  vpc_id      = aws_vpc.main.id

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTPS"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "public-sg"
  }
}


# =========================================================
# PRIVATE EC2 SECURITY GROUP
# =========================================================

resource "aws_security_group" "private_sg" {
  name        = "private-sg"
  description = "Security group for private EC2"
  vpc_id      = aws_vpc.main.id

  ingress {
    description     = "SSH from Public EC2"
    from_port       = 22
    to_port         = 22
    protocol        = "tcp"
    security_groups = [aws_security_group.public_sg.id]
  }

  ingress {
    description     = "HTTP from Public EC2"
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = [aws_security_group.public_sg.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "private-sg"
  }
}


# =========================================================
# RDS SECURITY GROUP
# =========================================================

resource "aws_security_group" "rds_sg" {
  name        = "rds-sg"
  description = "Security group for RDS MySQL"
  vpc_id      = aws_vpc.main.id

  ingress {
    description     = "MySQL from Private EC2"
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    security_groups = [aws_security_group.private_sg.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "rds-sg"
  }
}


# =========================================================
# INTERNET GATEWAY
# =========================================================

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = var.internet_gateway_tag
  }
}


# =========================================================
# PUBLIC ROUTE TABLE
# =========================================================

resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "test-public-rt"
  }
}


# =========================================================
# PUBLIC ROUTE TABLE ASSOCIATIONS
# =========================================================

resource "aws_route_table_association" "public_assoc_1" {
  subnet_id      = aws_subnet.public_1.id
  route_table_id = aws_route_table.public_rt.id
}

resource "aws_route_table_association" "public_assoc_2" {
  subnet_id      = aws_subnet.public_2.id
  route_table_id = aws_route_table.public_rt.id
}


# =========================================================
# ELASTIC IP FOR NAT GATEWAY
# =========================================================

resource "aws_eip" "nat_eip" {
  domain = "vpc"

  tags = {
    Name = "test-nat-eip"
  }
}


# =========================================================
# NAT GATEWAY
# =========================================================

resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id     = aws_subnet.public_1.id

  tags = {
    Name = "test-nat-gateway"
  }

  depends_on = [
    aws_internet_gateway.igw
  ]
}


# =========================================================
# PRIVATE ROUTE TABLE
# =========================================================

resource "aws_route_table" "private_rt" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat.id
  }

  tags = {
    Name = "test-private-rt"
  }
}


# =========================================================
# PRIVATE ROUTE TABLE ASSOCIATIONS
# =========================================================

resource "aws_route_table_association" "private_assoc_1" {
  subnet_id      = aws_subnet.private_1.id
  route_table_id = aws_route_table.private_rt.id
}

resource "aws_route_table_association" "private_assoc_2" {
  subnet_id      = aws_subnet.private_2.id
  route_table_id = aws_route_table.private_rt.id
}


# =========================================================
# PUBLIC EC2 INSTANCE
# =========================================================

resource "aws_instance" "web" {
  ami           = "ami-0c1bed477f4225f83"
  instance_type = "t3.micro"

  availability_zone = "eu-north-1a"
  subnet_id         = aws_subnet.public_1.id

  vpc_security_group_ids = [
    aws_security_group.public_sg.id
  ]

  key_name = "alpkey"

  tags = {
    Name = "public-instance"
  }
}


# =========================================================
# PRIVATE EC2 INSTANCE
# =========================================================

resource "aws_instance" "private_web" {
  ami           = "ami-0c1bed477f4225f83"
  instance_type = "t3.micro"

  availability_zone = "eu-north-1a"
  subnet_id         = aws_subnet.private_1.id

  vpc_security_group_ids = [
    aws_security_group.private_sg.id
  ]

  key_name = "alpkey"

  tags = {
    Name = "private-instance"
  }
}


# =========================================================
# RDS SUBNET GROUP
# =========================================================

resource "aws_db_subnet_group" "rds_subnet_group" {
  name = "test-rds-subnet-group"

  subnet_ids = [
    aws_subnet.private_1.id,
    aws_subnet.private_2.id
  ]

  tags = {
    Name = "test-rds-subnet-group"
  }
}


# =========================================================
# RDS MYSQL DATABASE
# =========================================================

resource "aws_db_instance" "mysql" {
  identifier = "test-mysql"

  engine         = "mysql"
  engine_version = "8.0"

  instance_class        = "db.t3.micro"
  allocated_storage     = 20
  max_allocated_storage = 100
  storage_type          = "gp3"

  db_name  = "testdb"
  username = "admin"
  password = "Cloud123!"

  db_subnet_group_name   = aws_db_subnet_group.rds_subnet_group.name
  vpc_security_group_ids = [aws_security_group.rds_sg.id]

  publicly_accessible = false
  multi_az            = false

  backup_retention_period = 7
  skip_final_snapshot     = true

  tags = {
    Name = "test-mysql"
  }
}


resource "null_resource" "database_setup" {

  triggers = {
    rds_instance_id = aws_db_instance.mysql.id

    sql_file_hash = filemd5(
      "${path.module}/init.sql"
    )
  }

  provisioner "file" {
    source      = "${path.module}/init.sql"
    destination = "/tmp/init.sql"

    connection {
      type        = "ssh"
      user        = "ec2-user"

      private_key = file(
        "C:/Users/kanav/Downloads/alpkey.pem"
      )

      host = aws_instance.private_web.private_ip

      bastion_host = aws_instance.web.public_ip
      bastion_user = "ec2-user"

      bastion_private_key = file(
        "C:/Users/kanav/Downloads/alpkey.pem"
      )
    }
  }

  provisioner "remote-exec" {
    inline = [
      "sudo dnf install mariadb105 -y || sudo yum install mariadb -y",

      "mysql -h ${aws_db_instance.mysql.address} -u ${aws_db_instance.mysql.username} -p'${var.db_password}' ${aws_db_instance.mysql.db_name} < /tmp/init.sql"
    ]

    connection {
      type        = "ssh"
      user        = "ec2-user"

      private_key = file(
        "C:/Users/kanav/Downloads/alpkey.pem"
      )

      host = aws_instance.private_web.private_ip

      bastion_host = aws_instance.web.public_ip
      bastion_user = "ec2-user"

      bastion_private_key = file(
        "C:/Users/kanav/Downloads/alpkey.pem"
      )
    }
  }

  depends_on = [
    aws_db_instance.mysql,
    aws_instance.private_web,
    aws_instance.web
  ]
}