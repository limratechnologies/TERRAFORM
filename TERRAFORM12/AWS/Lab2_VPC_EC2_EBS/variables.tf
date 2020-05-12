#----root/variables.tf-----
variable "AWS_REGION" {}
variable "AWS_ACCESS_KEY" {}
variable "AWS_SECRET_KEY" {}


#-------networking variables
variable "vpc_cidr" {}
variable "public_cidrs" {
  type = "list"
}
variable "accessip" {}

#-------compute variables
variable "key_name" {}
variable "public_key_path" {}
variable "private_key_path" {}
variable "server_instance_type" {}
variable "instance_count" {}
variable "server_ami" {}

variable "disks_size" {}

variable "ec2_ebs_count" {}

variable "data_disks" {
  description = "device list for EC2 mapping"
  type = set(string)
}

variable "dnodes" {
  type = set(string)
}

#variable "ec2_name" {}


