#!/bin/bash
   yum update -y
    yum install git -y
    yum install nginx -y

  systemctl start nginx
  systemctl enable nginx

    echo "Hello from Terraform" > /usr/share/nginx/html/index.html
  EOF