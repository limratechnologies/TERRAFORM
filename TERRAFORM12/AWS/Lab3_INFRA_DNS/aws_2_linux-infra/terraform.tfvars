AWS_REGION       = "us-east-1"
AWS_ACCESS_KEY   = "XXXXXXXXXXXXXXXXXXXX"
AWS_SECRET_KEY   = "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX"

subnets          = [ "subnet-04452ab27750e9859", "subnet-06c4b25aa8da62b89" ]
security_group   = ["sg-03e536f8e659060df"]

project_name     = "la-terraform"

key_name         = "admin_key"

public_key_path  = "/root/.ssh/id_rsa.pub"
private_key_path = "/root/.ssh/id_rsa"

instance_type    = "t2.medium"

server_ami       = "ami-004cd5eb616d96667"

instance_count   = 4
ec2_ebs_count    = 1

disks_size       = "20"

data_disks       = [ "/dev/sdg"  ]

dnodes           = [ "1", "2", "3", "4" ]

instance_tags = [ "P_CHEF-SERVER", "P_CHEF-WORKSTATION", "P_RUNDECK-SERVER", "P_CHECK-MK-SERVER" ]
