provider "aws" {
  region     = "${var.AWS_REGION}"
  access_key = "${var.AWS_ACCESS_KEY}"
  secret_key = "${var.AWS_SECRET_KEY}"
}

# Deploy Networking Resources
module "networking" {
  source       = "./networking"
  vpc_cidr     = "${var.vpc_cidr}"
  public_cidrs = "${var.public_cidrs}"
  accessip    = "${var.accessip}"
}

# Deploy Linux servers IDM + Clients
module "compute" {
  source           = "./compute"
  instance_count   = "${var.instance_count}"
  key_name         = "${var.key_name}"
  public_key_path  = "${var.public_key_path}"
  private_key_path = "${var.private_key_path}"
  instance_type    = "${var.ec2_type}"
  server_ami       = "${var.server_ami}"
  subnets          = "${module.networking.public_subnets}"
  security_group   = "${module.networking.public_sg}"
  subnet_ips       = "${module.networking.subnet_ips}"
  disks_size       = "${var.disks_size}"
  ec2_ebs_count    = "${var.ec2_ebs_count}"
  dnodes           = "${var.dnodes}"
  instance_tags    = "${var.instance_tags}"
  data_disks       = "${var.data_disks}"
}

# Deploy AD Windows server
module "windows-ad" {
  source             = "./windows-ad"
  win_instance_count = "${var.win_instance_count}"
  windows_ami        = "${var.windows_ami}"
  win_instance_tag   = "${var.win_instance_tag}"
  key_name           = "${var.key_name}"
  private_key_path   = "${var.private_key_path}"
  instance_type      = "${var.ec2_type}"
  subnets            = "${module.networking.public_subnets}"
  security_group     = "${module.networking.public_sg}"
  win_disks_size     = "${var.win_disks_size}"
  ec2_ebs_tags       = "${var.ec2_ebs_tags}"
  win_ec2_ebs_count  = "${var.win_ec2_ebs_count}"
  ec2_ebs_names      = "${var.ec2_ebs_names}"
  admin_user         = "${var.admin_user}"
  admin_password     = "${var.admin_password}"
}

