#----root/outputs.tf-----


#---Networking Outputs -----
output "Public_Subnets" {
  value = "${join(", ", module.networking.public_subnets)}"
}

output "Subnet_IPs" {
  value = "${join(", ", module.networking.subnet_ips)}"
}

output "Public_Security_Group" {
  value = "${module.networking.public_sg}"
}


#---Compute Outputs ------
output "Instances_IDs" {
  value = "${module.compute.public_ec2_ids}"
}

output "Instances_Public_IPs" {
  value = "${module.compute.public_ec2_ips}"
}

output "Instances_HOSTNAME" {
  value = "${module.compute.public_ec2_host}"
}
