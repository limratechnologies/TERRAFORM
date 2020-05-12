
data "template_file" "domain_join" {
  template = "${file("${path.module}/post_install_template.tpl")}"
  vars = {
    vm_name_netbios       = "${var.vm_name_netbios}"
    vm_name_domain        = "${var.windomain}"
    vm_admin_user         = "${var.admin_user}"
    domain_admin_password = "${base64decode(var.domain_admin_password)}"
  }
}

resource "aws_instance" "win_server" {
  count                  = "${var.instance_count}"
  instance_type          = "${var.instance_type}"
  ami                    = "${var.ami}"
  tags                   = { Name  = "${lower(element(var.instance_tags, count.index))}.${var.windomain}" }
  key_name               = "${var.key_name}"
  vpc_security_group_ids = "${var.ec2_sg_ids}"
  subnet_id              = "${var.subnet_id}"
  connection {
     host     = "${self.private_ip}"
     type     = "winrm"
     https    = false
     password = "${var.admin_password}"
     agent    = false
     insecure = "true"
   }
   provisioner "remote-exec" {
     inline = ["powershell.exe -Command Rename-Computer -NewName '${lower(element(var.instance_tags, count.index))}' -Restart"]
   }
   provisioner "file" {
     content      = "${data.template_file.domain_join.rendered}"
     destination = "C:\\Temp\\post_install_template.ps1"
   }
}

resource "aws_ebs_volume" "ebs_volume" {
  count             = "${var.instance_count * var.ec2_ebs_count}"
  availability_zone = "${element(aws_instance.win_server.*.availability_zone, count.index)}"
  size              = "${element(var.disks_size, count.index)}"
  encrypted         = "true"
  kms_key_id        = "${var.ec2_ebs_kms_key_id}"
  tags = { Name  = "${element(var.instance_tags, count.index)}_${element(var.ec2_ebs_tags, count.index)}" }
}

resource "aws_volume_attachment" "volume_attachement" {
  count       = "${var.instance_count * var.ec2_ebs_count}"
  volume_id   = "${aws_ebs_volume.ebs_volume.*.id[count.index]}"
  device_name = "${element(var.ec2_ebs_names, count.index)}"
  instance_id = "${element(aws_instance.win_server.*.id, count.index)}"
}

resource "null_resource" "post_install" {
   depends_on = [aws_volume_attachment.volume_attachement]
   count         = "${var.instance_count}"
   connection {
     host     = "${element(aws_instance.win_server.*.private_ip, count.index)}"
     type     = "winrm"
     https    = false
     password = "${var.admin_password}"
     agent    = false
     insecure = "true"
   }
   provisioner "remote-exec" {
     inline = ["powershell.exe C:\\Temp\\post_install_template.ps1"]
     on_failure = "continue"
   }
   provisioner "local-exec" {
     command = "knife node environment set ${lower(element(var.instance_tags, count.index))}.${var.windomain} ${var.chef_env}"
     on_failure = "continue"
   }
   provisioner "local-exec" {
     command = "knife node run_list add ${lower(element(var.instance_tags, count.index))}.${var.windomain} ${var.chef_run_list}"
     on_failure = "continue"
   }
   provisioner "remote-exec" {
    inline = ["powershell.exe -Command Remove-Item C:\\Temp\\post_install_template.ps1"]
    on_failure = "continue"
   }
   provisioner "remote-exec" {
    inline = ["powershell.exe -Command Restart-Computer -Force"]
    on_failure = "continue"
   }
   triggers = {
     "after" = "${element(aws_instance.win_server.*.id, count.index)}"
  }
}

resource "dns_a_record_set" "cloud" {
  count     = "${var.instance_count}"
  zone      = "lab.example.com."
  name      = "${lower(element(var.instance_tags, count.index))}.${var.dnsdomain}"  
  addresses = ["${element(aws_instance.win_server.*.private_ip, count.index)}"]
  ttl       = 3600
}

resource "dns_cname_record" "cloud" {
  count     = "${var.instance_count}"
  zone      = "lab.example.com."
  name      = "${lower(element(var.instance_tags, count.index))}"
  cname     = "${lower(element(var.instance_tags, count.index))}.${var.dnsdomain}.lab.example.com."
  ttl       = 3600
}

