provider "aws" {
  region     = "${var.AWS_REGION}"
}

provider "dns" {
  update {
    server = "dns-server.example.local"
  }
}

module "windows-server" {
  source                 = "./windows-server"
  ami                    = "${var.ami}"
  instance_count         = "${var.instance_count}"
  instance_tags          = "${var.instance_tags}"
  key_name               = "${var.key_name}"
  instance_type          = "${var.server_instance_type}"
  subnets                = "${var.subnets}"
  disks_size             = "${var.disks_size}"
  ec2_ebs_tags           = "${var.ec2_ebs_tags}"
  ec2_ebs_count          = "${var.ec2_ebs_count}"
  ec2_ebs_names          = "${var.ec2_ebs_names}"
  ec2_ebs_kms_key_id     = "${var.ec2_ebs_kms_key_id}"
  ec2_sg_ids             = "${var.ec2_sg_ids}"
  subnet_id              = "${var.subnet_id}"
  admin_user             = "${var.admin_user}"
  admin_password         = "${var.admin_password}"
  domain_admin_password  = "${var.domain_admin_password}"
  vm_name_netbios        = "${var.vm_name_netbios}"
  windomain              = "${var.windomain}"
  dnsdomain              = "${var.dnsdomain}"
  chef_env               = "${var.chef_env}"
  chef_run_list          = "${var.chef_run_list}"
}
