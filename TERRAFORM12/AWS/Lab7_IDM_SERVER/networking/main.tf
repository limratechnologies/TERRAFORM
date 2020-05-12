#----networking/main.tf----

variable "ingress_ports_tcp" {
  type        = list(number)
  description = "list of ingress ports"
  default     = [ 22, 53, 80, 88, 135, 138, 139, 389, 443, 445, 464, 636, 3268, 3389, 5985, 5986, 6556, 8000, 9000 ]
}
variable "ingress_ports_udp" {
  type        = list(number)
  description = "list of ingress ports"
  default     = [ 53, 88, 138, 123, 139, 389, 445, 464 ]
}

variable "egress_ports" {
  type        = list(number)
  description = "list of ingress ports"
  default     = [ 0 ]
}

data "aws_availability_zones" "available" {}

resource "aws_vpc" "tf_vpc" {
  cidr_block           = "${var.vpc_cidr}"
  enable_dns_hostnames = true
  enable_dns_support   = true
  tags = {
    Name = "VPC_AR1-QAL-D"
  }
}

resource "aws_internet_gateway" "tf_internet_gateway" {
  vpc_id = "${aws_vpc.tf_vpc.id}"
  tags = {
    Name = "IGW-AR1-EXT-VPC"
  }
}

resource "aws_route_table" "tf_public_rt" {
  vpc_id = "${aws_vpc.tf_vpc.id}"
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.tf_internet_gateway.id}"
  }
  tags = {
    Name = "RT_AR1-EXT_MG"
  }
}

resource "aws_default_route_table" "tf_private_rt" {
  default_route_table_id  = "${aws_vpc.tf_vpc.default_route_table_id}"
  tags = {
    Name = "RT_AR1-QAL_DEFAULT"
  }
}

resource "aws_subnet" "tf_public_subnet" {
  count                   = 2
  vpc_id                  = "${aws_vpc.tf_vpc.id}"
  cidr_block              = "${var.public_cidrs[count.index]}"
  map_public_ip_on_launch = true
  availability_zone       = "${data.aws_availability_zones.available.names[count.index]}"
  tags = {
    Name = "SN_AR1-QAL_D_BACK_${count.index + 1}"
  }
}

resource "aws_route_table_association" "tf_public_assoc" {
  count          = 2
  subnet_id      = "${aws_subnet.tf_public_subnet.*.id[count.index]}"
  route_table_id = "${aws_route_table.tf_public_rt.id}"
}

resource "aws_security_group" "tf_public_sg" {
  name        = "SG_AR1-QAL_BACK"
  description = "Used for access to the public instances"
  vpc_id      = "${aws_vpc.tf_vpc.id}"

  dynamic "ingress" {
    iterator = port
    for_each = var.ingress_ports_tcp
    content {
      from_port   = port.value
      to_port     = port.value
      protocol    = "tcp"
      cidr_blocks = ["${var.accessip}"]
    }
  }
  dynamic "ingress" {
    iterator = port
    for_each = var.ingress_ports_udp
    content {
      from_port   = port.value
      to_port     = port.value
      protocol    = "udp"
      cidr_blocks = ["${var.accessip}"]
    }
  }
  ingress {
    from_port   = 1024
    to_port     = 1300
    protocol    = "udp"
    cidr_blocks = ["${var.accessip}"]
  }

  dynamic "egress" {
    iterator = port
    for_each = var.egress_ports
    content {
      from_port   = port.value
      to_port     = port.value
      protocol    = "-1"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }
}
