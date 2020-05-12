variable "AWS_REGION" {}

variable "key_name" {}
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

variable "ec2_ebs_kms_key_id" {}

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

variable "domain_admin_password" {
  default     = null
}

variable "vm_name_netbios" {}
variable "dnsdomain" {}
variable "windomain" {}
variable "chef_env" {} 
variable "chef_run_list" {} 

