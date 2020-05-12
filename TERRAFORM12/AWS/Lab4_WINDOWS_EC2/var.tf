variable "AWS_ACCESS_KEY" {}
variable "AWS_SECRET_KEY" {}

variable "AWS_REGION" {
 default = "us-east-1"
}

variable "WIN_AMIS" {
 type = "map"
   default = {
    us-east-1 = "ami-08bf5f54919fada4a"
    us-west-2 = "ami-08bf5f54919fada4a"
    eu-west-1 = "ami-08bf5f54919fada4a"
 }
}

variable "PATH_TO_PRIVATE_KEY" {
 default = "mykey"
}

variable "PATH_TO_PUBLIC_KEY" {
 default = "mykey.pub"
}
variable "INSTANCE_USERNAME" {
 default = "admin"
}

variable "INSTANCE_PASSWORD" { }


