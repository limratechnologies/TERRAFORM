variable "key_name" {}

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

variable "ec2_ebs_kms_key_id" {}

variable "ec2_ebs_count" {}

variable "ec2_ebs_names" {
  type = "list"
}

variable "ec2_sg_ids" {
  type = "list"
}

variable "subnet_id" {}
variable "ami" {}

variable "chef_env" {}

variable "chef_run_list" {
  type = "string"
  description = "roles/recipes for chef run list"
}

variable "dnsdomain" {}

variable "windomain" {
  description = "The domain to join for this virtual machine. One of this or workgroup must be included."
}

variable "vm_name_netbios" {
  description = "Server Netbios name "
}

variable "admin_user" {
  description = "Server local Administrator user"
}

variable "admin_password" {}

variable "domain_admin_password" {}
