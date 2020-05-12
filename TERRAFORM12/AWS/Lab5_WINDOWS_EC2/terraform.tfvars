AWS_REGION           = "eu-west-3"
project_name         = "win-terraform"
key_name             = "admin_key"

instance_count       = 1
ami                  = "ami-xxxxxxxxxxxxx"
server_instance_type = "m5.large"
instance_tags        = [ "WINDOWS-A01" ]
subnet_id            = "subnet-xxxxxxxxxxxx"
ec2_ebs_kms_key_id   = "arn:aws:kms:xxxxxxxxxx:key/xxxxxxxxxxxxxxxxx"
ec2_sg_ids           = [ "sg-xxxxxxxxxxxx", "sg-xxxxxxxxxxxx", "sg-xxxxxxxxxxx", "sg-xxxxxxxxxxxxxx" ]

ec2_ebs_count        = 2
ec2_ebs_tags         = [ "AP1", "AP2" ]
ec2_ebs_names        = [ "/dev/xvdf", "/dev/xvdg" ]
disks_size           = [ "20", "20" ]

admin_user           = "Administrator"
vm_name_netbios      = "ad-domain"
windomain            = "ad-domain.example.local"
dnsdomain            = "env.proto"
chef_env             = "ENV-PROTO"
chef_run_list        = "'role[base]' 'role[win_server]'"
