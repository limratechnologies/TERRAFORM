variable "AWS_REGION" {}
variable "AWS_ACCESS_KEY" {}
variable "AWS_SECRET_KEY" {}

variable "key_name" {}
variable "priv_key_path" {}

variable "server_instance_type" {}
variable "instance_count" {
  default = 1
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

variable "admin_user" {}

variable "ec2_sg_ids" {}

variable "subnets" {
  default = []
}

variable "subnet_id" {}

variable "ami" {}

variable "admin_password" {
  default     = null
}

