# this resource is for data 

data "aws_ami" "dev-frontend" {
    most_recent = true

    owners = ["amazon"]

    filter {
      name = "image-id"
      values = [ "ami-0c1bed477f4225f83" ]
    }

    filter {
      name = "state"
      values = [ "available" ]
    }

    
}

# this resource is key pair

data "aws_key_pair" "devloadbal" {
    key_name = "devloadbal"
  
}


# this resource is for security group 
data "aws_security_group" "dev-sg" {
    
    filter {
      name = "group-name"
      values = [ "dev-sg" ]
    }
}

# this resource is for improting ec2 instance from aws to local terraform

resource "aws_instance" "imported_ec2" {

    ami = data.aws_ami.dev-frontend.id
    instance_type = "t3.micro"

    key_name = data.aws_key_pair.devloadbal.id
    vpc_security_group_ids = [data.aws_security_group.dev-sg.id]

    tags = {
      Name = "dev-frontend"
    }
  
}

# terraform import aws_instance.imported_ec2 i-06c012cd55ac062f2