data "template_file" "domain_join" {
  template = "${file("${path.module}/post_install_template.tpl")}"
}

resource "aws_instance" "ad_server" {
  count                  = "${var.win_instance_count}"
  instance_type          = "t2.medium"
  ami                    = "${var.windows_ami}"
  tags                   = { Name  = "${element(var.win_instance_tag, count.index)}" } 
  key_name               = "${var.key_name}"
  vpc_security_group_ids = ["${var.security_group}"]
  subnet_id              = "${element(var.subnets, 1 )}"
  private_ip             = "10.123.2.99"
  user_data     = <<EOF
<powershell>
winrm set winrm/config/service/auth '@{Basic="true"}'
winrm set winrm/config/service '@{AllowUnencrypted="true"}'
netsh advfirewall firewall add rule name="WinRM 5985" protocol=TCP dir=in localport=5985 action=allow
netsh advfirewall firewall add rule name="WinRM 5986" protocol=TCP dir=in localport=5986 action=allow
</powershell>
EOF
  get_password_data      = "true"

   connection {
     host     = "${self.public_ip}"
     type     = "winrm"
     https    = false
     password = "${rsadecrypt(self.password_data, file(var.private_key_path))}"
     agent    = false
     insecure = "true"
   }
   provisioner "remote-exec" {
     inline = ["powershell.exe -Command Rename-Computer -NewName '${lower(element(var.win_instance_tag, count.index))}' -Restart"]
   }
   provisioner "remote-exec" {
     inline = ["powershell.exe -Command net user Administrator ${var.admin_password}"]
   }
}

resource "aws_ebs_volume" "ebs_volume" {
  count             = "${var.win_instance_count * var.win_ec2_ebs_count}"
  availability_zone = "${element(aws_instance.ad_server.*.availability_zone, count.index)}"
  size              = "${element(var.win_disks_size, count.index)}"
  encrypted         = "true"
  tags = { Name  = "${element(var.win_instance_tag, count.index)}_${element(var.ec2_ebs_tags, count.index)}" }
}

resource "aws_volume_attachment" "volume_attachement" {
  count       = "${var.win_instance_count * var.win_ec2_ebs_count}"
  volume_id   = "${aws_ebs_volume.ebs_volume.*.id[count.index]}"
  device_name = "${element(var.ec2_ebs_names, count.index)}"
  instance_id = "${element(aws_instance.ad_server.*.id, count.index)}"
}

resource "null_resource" "post_install" {
   depends_on = [aws_volume_attachment.volume_attachement]
   count         = "${var.win_instance_count}"
   connection {
     host     = "${element(aws_instance.ad_server.*.public_ip, count.index)}"
     type     = "winrm"
     https    = false
     password = "${var.admin_password}"
     agent    = false
     insecure = "true"
   }
   provisioner "file" {
     content      = "${data.template_file.domain_join.rendered}"
     destination = "C:\\Temp\\post_install_template.ps1"
   }
   provisioner "remote-exec" {
     inline = ["powershell.exe C:\\Temp\\post_install_template.ps1"]
     on_failure = "continue"
   }
   provisioner "file" {
     source      = "./windows-ad/post_install_template2.ps1"
     destination = "C:/Temp/post_install_template2.ps1"
   }
   provisioner "remote-exec" {
     inline = ["powershell.exe C:\\Temp\\post_install_template2.ps1"]
     on_failure = "continue"
   }

   triggers = {
     "after" = "${element(aws_instance.ad_server.*.id, count.index)}"
  }
}
