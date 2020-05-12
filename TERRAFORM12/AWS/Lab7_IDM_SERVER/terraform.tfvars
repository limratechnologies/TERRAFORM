AWS_REGION       = "us-east-1"
AWS_ACCESS_KEY   = "XXXXXXXXXXXXXXXXXXXX"
AWS_SECRET_KEY   = "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXX"

project_name     = "la-terraform"
vpc_cidr         = "10.123.0.0/16"
public_cidrs     = [ "10.123.1.0/24", "10.123.2.0/24" ]

accessip         = "0.0.0.0/0"

key_name         = "admin_key"

public_key_path  = "/root/.ssh/id_rsa.pub"
private_key_path = "/root/.ssh/id_rsa"

server_instance_type = "t2.medium"

server_ami       = "ami-004cd5eb616d96667"

instance_count   = 3
ec2_ebs_count    = 1
disks_size       = "20"
data_disks       = [ "/dev/sdg"  ]
dnodes           = [ "1", "2", "3" ]

instance_tags = [ "IDM-SERVER", "CLIENT-D01", "CLIENT-D02" ]
