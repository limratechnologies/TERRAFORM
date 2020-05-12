variable "key_name" {}
variable "private_key_path" {}

variable "win_instance_count" {}

variable "instance_type" {}

variable "subnets" {
  type = "list"
}

variable "win_instance_tag" {
  type = "list"
}

variable "win_disks_size" {
  type = "list"
}

variable "ec2_ebs_tags" {
  type = "list"
}

variable "win_ec2_ebs_count" {}

variable "ec2_ebs_names" {
  type = "list"
}

variable "windows_ami" {}

variable "admin_user" {
  description = "Local Administrator user of windows VM template"
}

variable "admin_password" {}

variable "security_group" {}
