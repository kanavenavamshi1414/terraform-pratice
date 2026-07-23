variable "cidr_port_map" {
  type = map(list(number))

  default = {
    # Public subnet → ALB/EC2
    "10.0.1.0/24" = [80, 443, 8080]

    # Private subnet → RDS
    "10.0.2.0/24" = [3306]

    # Your own public IP → SSH
    "49.43.203.62/32" = [22]
  }
}