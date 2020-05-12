#-----compute/variables.tf

variable "key_name" {}

variable "public_key_path" {}
variable "private_key_path" {}

variable "subnet_ips" {
  type = "list"
}

variable "server_ami" {}

variable "instance_count" {}

variable "instance_type" {}

variable "security_group" {}

variable "subnets" {
  type = "list"
}

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
