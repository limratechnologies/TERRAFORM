variable "key_name" {}
variable "priv_key_path" {}

variable "instance_count" {}

variable "instance_type" {}

variable "subnets" {
  type = "list"
}

variable "instance_tags" {
  type = "list"
}

variable "disks_size" {
  type = "list"
}

variable "ec2_ebs_tags" {
  type = "list"
}

variable "ec2_ebs_count" {}

variable "ec2_ebs_names" {
  type = "list"
}

variable "ec2_sg_ids" {
  type = "list"
}

variable "subnet_id" {}
variable "ami" {}


variable "admin_user" {
  description = "Local Administrator user of windows VM template"
}

variable "admin_password" {}
