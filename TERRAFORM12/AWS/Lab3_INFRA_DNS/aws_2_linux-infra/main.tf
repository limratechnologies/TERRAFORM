#----------------compute/main.tf#------------------
provider "aws" {
  region     = "${var.AWS_REGION}"
  access_key = "${var.AWS_ACCESS_KEY}"
  secret_key = "${var.AWS_SECRET_KEY}"
}

resource "aws_key_pair" "tf_auth" {
  key_name   = "${var.key_name}"
  public_key = "${file(var.public_key_path)}"
}

locals {
  node_disks = { for pair in setproduct(var.dnodes, var.data_disks) : "${pair[0]}:${pair[1]}" => {
    node_name     = pair[0]
    disk_dev_path = pair[1]
  } }
}
#---------------------------------------------------------------------------------------------------------------------
#-EC2 management-
#---------------------------------------------------------------------------------------------------------------------
resource "aws_instance" "tf_server" {
  for_each = var.dnodes

  instance_type          = "${var.instance_type}"
  ami                    = "${var.server_ami}"
  tags                   = {Name   = "${element(var.instance_tags, each.value)}"}
  key_name               = "${aws_key_pair.tf_auth.id}"
  vpc_security_group_ids = "${var.security_group}"
  subnet_id              = "${element(var.subnets, (each.value % 2) + 1 )}"
  user_data = <<EOF
#!/bin/bash
hostnamectl set-hostname ${element(var.instance_tags, each.value)}
EOF
}
#---------------------------------------------------------------------------------------------------------------------
#-EBS management-
#---------------------------------------------------------------------------------------------------------------------
resource "aws_ebs_volume" "ebs_volume" {
  for_each = local.node_disks
    availability_zone = "${aws_instance.tf_server[each.value.node_name].availability_zone}"
    size              = "${var.disks_size}"
    tags              = {Name = "${element(var.instance_tags, each.value.node_name)}_${each.value.disk_dev_path}"}
}

resource "aws_volume_attachment" "volume_attachement" {
  for_each = local.node_disks
   device_name  = each.value.disk_dev_path
   instance_id  = aws_instance.tf_server[each.value.node_name].id
   volume_id    = aws_ebs_volume.ebs_volume[each.key].id
}

#---------------------------------------------------------------------------------------------------------------------
#-Post install scripts-
#---------------------------------------------------------------------------------------------------------------------
resource "null_resource" "post_install" {
  for_each = var.dnodes 
  depends_on = [aws_volume_attachment.volume_attachement]
  
  connection {
    type        = "ssh"
    host        = aws_instance.tf_server[each.key].public_ip
    user        = "centos"
    port        = "22"
    private_key = "${file(var.private_key_path)}"
    agent       = false
  }
  provisioner "file" {
    source      = "scripts/post_install.sh"
    destination = "/tmp/post_install.sh"
  }
  provisioner "remote-exec" {
    inline = [
      "sudo bash /tmp/post_install.sh"
    ]
  }
}

#------------------------------------------------------
