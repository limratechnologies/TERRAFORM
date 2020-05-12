AWS_REGION           = "us-east-1"
AWS_ACCESS_KEY       = "XXXXXXXXXXXXXXXXXXXXX"
AWS_SECRET_KEY       = "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX"

project_name         = "ad-terraform"
key_name             = "admin_key"
priv_key_path        = "/root/.ssh/id_rsa"

instance_count       = 1
ami                  = "ami-02fc0cb4aa47ce2e9"
server_instance_type = "t2.medium"
instance_tags        = [ "SERVER-AD-A01" ]

subnet_id            = "subnet-04e119d9ad047c5d9"
ec2_sg_ids           = [ "sg-0afb033a020828ad1" ]

ec2_ebs_count        = 2
ec2_ebs_tags         = [ "APP", "FF" ]
ec2_ebs_names        = [ "/dev/xvdf", "/dev/xvdg" ]
disks_size           = [ "40", "40" ]

admin_user           = "Administrator"
