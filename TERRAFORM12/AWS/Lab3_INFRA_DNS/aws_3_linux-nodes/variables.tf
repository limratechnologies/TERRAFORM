#-----compute/variables.tf

variable "AWS_REGION" {}
variable "AWS_ACCESS_KEY" {}
variable "AWS_SECRET_KEY" {}

variable "key_name" {}

variable "public_key_path" {}
variable "private_key_path" {}

variable "datacenter" {
  type = string
  description = "vsphere datacenter"
}

variable "platform" {
  type = string
}

variable "vm_name_abbr" {
  type = string
}

variable "vm_node_id" {
  type = string
}

variable "vm_name_count" {
  description = "vm_name_count"
  default = "1"
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

variable "ec2_name" {}

