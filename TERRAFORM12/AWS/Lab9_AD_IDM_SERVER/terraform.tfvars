AWS_REGION         = "us-east-1"
AWS_ACCESS_KEY     = "XXXXXXXXXXXXXXXXXXX"
AWS_SECRET_KEY     = "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX"

project_name       = "la-terraform"
vpc_cidr           = "10.123.0.0/16"
public_cidrs       = [ "10.123.1.0/24", "10.123.2.0/24" ]

accessip           = "0.0.0.0/0"
key_name           = "admin_key"
public_key_path    = "/root/.ssh/id_rsa.pub"
private_key_path   = "/root/.ssh/id_rsa"

ec2_type           = "t2.medium"

server_ami         = "ami-004cd5eb616d96667"
instance_count     = 5
ec2_ebs_count      = 1
disks_size         = "20"
data_disks         = [ "/dev/sdg"  ]
dnodes             = [ "1", "2", "3" , "4", "5" ]
instance_tags      = [ "IDM-SERVER", "IDM-REPLICA", "CLIENT-D01", "CLIENT-D02", "CLIENT-D03" ]

win_instance_count = 1
windows_ami        = "ami-02fc0cb4aa47ce2e9"
win_instance_tag   = [ "SERVER-AD-A01" ]
win_ec2_ebs_count  = 2
ec2_ebs_tags       = [ "APP", "FF" ]
ec2_ebs_names      = [ "/dev/xvdf", "/dev/xvdg" ]
win_disks_size     = [ "40", "40" ]
admin_user         = "Administrator"
