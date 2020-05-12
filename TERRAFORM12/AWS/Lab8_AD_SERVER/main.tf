provider "aws" {
  region     = "${var.AWS_REGION}"
  access_key = "${var.AWS_ACCESS_KEY}"
  secret_key = "${var.AWS_SECRET_KEY}"

}

module "windows-ad" {
  source                 = "./windows-ad"
  ami                    = "${var.ami}"
  instance_count         = "${var.instance_count}"
  instance_tags          = "${var.instance_tags}"
  key_name               = "${var.key_name}"
  priv_key_path          = "${var.priv_key_path}"
  instance_type          = "${var.server_instance_type}"
  subnets                = "${var.subnets}"
  disks_size             = "${var.disks_size}"
  ec2_ebs_tags           = "${var.ec2_ebs_tags}"
  ec2_ebs_count          = "${var.ec2_ebs_count}"
  ec2_ebs_names          = "${var.ec2_ebs_names}"
  ec2_sg_ids             = "${var.ec2_sg_ids}"
  subnet_id              = "${var.subnet_id}"
  admin_user             = "${var.admin_user}"
  admin_password         = "${var.admin_password}"
}
