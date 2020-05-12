AWS_REGION       = "us-east-1"

AWS_ACCESS_KEY = "XXXXXXXXXXXXXXXXXXXXXXXX"
AWS_SECRET_KEY = "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX"

subnets  = [ "subnet-0d802f4844a5a7afd", "subnet-0e3a183cba14a4d67" ]
security_group = ["sg-0be2093bbd7dfeeb5"]

project_name     = "la-terraform"

datacenter       = "AR1"
platform         = "QAL"
vm_name_abbr     = "SR"
vm_node_id       = "D"
vm_name_count    = "0"

key_name         = "admin_key"

public_key_path  = "/root/.ssh/id_rsa.pub"
private_key_path = "/root/.ssh/id_rsa"

instance_type = "t2.medium"

server_ami = "ami-004cd5eb616d96667"

instance_count = 3
ec2_ebs_count  = 1

disks_size = "20"

data_disks = [ "/dev/sdg"  ]

dnodes = [ "1", "2", "3" ]

ec2_name = "AR1-QAL-SR-D0"

