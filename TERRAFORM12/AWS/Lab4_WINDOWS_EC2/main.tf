resource "aws_key_pair" "mykey" {
  key_name   = "mykey"
  public_key = file(var.PATH_TO_PUBLIC_KEY)
}
 
data "template_file" "windows_script" {
  template = <<EOF
<script>
echo "" > _INIT_STARTED_
net user ${var.INSTANCE_USERNAME} /add /y
net user ${var.INSTANCE_USERNAME} ${var.INSTANCE_PASSWORD}
net localgroup administrators ${var.INSTANCE_USERNAME} /add
echo ${base64encode(file("./test.txt"))} > tmp2.b64 && certutil -decode tmp2.b64 C:/windows_script.ps1
echo "" > _INIT_COMPLETE_
</script>
<persist>false</persist>
EOF
}

resource "aws_instance" "windows_bc" {
  #ami           = "ami-08bf5f54919fada4a"
  ami           = "ami-02fc0cb4aa47ce2e9"
  instance_type = "t2.medium"
  key_name      = aws_key_pair.mykey.key_name
  user_data = <<EOF
<powershell>
net user admin /add /y
net user admin Ydkh13B8np12
net localgroup administrators admin /add
netsh advfirewall firewall add rule name="ICMP Allow incoming V4 echo request" protocol=icmpv4:8,any dir=in action=allow
netsh advfirewall firewall add rule name="WinRM in" protocol=TCP dir=in profile=any localport=5985 remoteip=any localip=any action=allow
netsh advfirewall firewall add rule name="RDP TCP in" protocol=TCP dir=in profile=any localport=3389 remoteip=any localip=any action=allow
netsh advfirewall firewall add rule name="RDP UDP in" protocol=UDP dir=in profile=any localport=3389 remoteip=any localip=any action=allow

</powershell>
EOF
  #user_data = data.template_file.windows_script.rendered

  network_interface {
    network_interface_id = "${aws_network_interface.net_1.id}"
    device_index         = 0
  }
  credit_specification {
    cpu_credits = "unlimited"
  }
  tags = {
    Name = "AR1-WIN01"
  }
}

output "public_ip" {
 value="${aws_instance.windows_bc.public_ip}"
}
