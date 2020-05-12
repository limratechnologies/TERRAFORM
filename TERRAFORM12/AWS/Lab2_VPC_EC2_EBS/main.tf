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

# Deploy Compute Resources
module "compute" {
  source          = "./compute"
  datacenter      = "AR1"
  platform        = "QAL"
  vm_name_abbr    = "SS"
  vm_node_id      = "Z"
  vm_name_count   = "0"
  instance_count  = "${var.instance_count}"
  key_name        = "${var.key_name}"
  public_key_path = "${var.public_key_path}"
  private_key_path = "${var.private_key_path}"
  instance_type   = "${var.server_instance_type}"
  server_ami      = "${var.server_ami}"
  subnets         = "${module.networking.public_subnets}"
  security_group  = "${module.networking.public_sg}"
  subnet_ips      = "${module.networking.subnet_ips}"
  disks_size      = "${var.disks_size}"
  ec2_ebs_count   = "${var.ec2_ebs_count}"
  dnodes          = "${var.dnodes}"
  data_disks      = "${var.data_disks}"
}
