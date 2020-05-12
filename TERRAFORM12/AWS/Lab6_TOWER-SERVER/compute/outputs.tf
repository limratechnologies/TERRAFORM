##-----compute/outputs.tf-----
#

output "public_ec2_ids" {
  value = {for k, o in aws_instance.tf_server : k => o.id}
}

output "public_ec2_ips" {
  value = {for k, o in aws_instance.tf_server : k => o.public_ip}
}

output "public_ec2_host" {
  value = {for k, o in aws_instance.tf_server : k => o.tags}
}

