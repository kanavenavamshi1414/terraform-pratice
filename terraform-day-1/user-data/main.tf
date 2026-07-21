resource "aws_instance" "name" {
    ami = "ami-0c1bed477f4225f83"
    instance_type = "t3.micro"
    user_data = file("userdata.sh")
    tags = {
        Name = "dev-2"
    }
  
}