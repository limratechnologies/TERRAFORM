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

#-------Linux servers deployment variables
variable "key_name" {}
variable "public_key_path" {}
variable "private_key_path" {}

variable "ec2_type" {}
variable "instance_count" {}
variable "win_instance_count" {}

variable "server_ami" {}
variable "windows_ami" {}

variable "disks_size" {}

variable "ec2_ebs_count" {}

variable "data_disks" {
  description = "device list for EC2 mapping"
  type = set(string)
}

variable "dnodes" {
  type = set(string)
}

variable "instance_tags" {
  type = "list"
}

#-------Windows servers deployment variables
variable "win_instance_tag" {
  type = "list"
}

variable "ec2_ebs_tags" {
  type = "list"
}

variable "admin_user" {}
variable "admin_password" {}

variable "ec2_ebs_names" {
  type = "list"
}

variable "win_disks_size" {
  type = "list"
}

variable "win_ec2_ebs_count" {}
