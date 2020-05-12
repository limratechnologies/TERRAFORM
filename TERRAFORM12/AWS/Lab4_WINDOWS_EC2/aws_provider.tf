provider "aws" {
 access_key = "${var.AWS_ACCESS_KEY}"
 secret_key = "${var.AWS_SECRET_KEY}"
 region     = "${var.AWS_REGION}"
}

terraform {
  required_version = ">= 0.12"
}

resource "aws_network_interface" "net_1" {
  subnet_id   = "subnet-02b50ef8559117698"
  private_ips = ["10.123.1.187"]

  tags = {
    Name = "primary_network_interface"
  }
}
