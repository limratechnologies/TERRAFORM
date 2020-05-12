provider "aws" {
  region     = "${var.AWS_REGION}"
  access_key = "${var.AWS_ACCESS_KEY}"
  secret_key = "${var.AWS_SECRET_KEY}"
}

resource "aws_route53_zone" "private" {
  name = "cmcloud-20042020.info"

}

resource "aws_route53_record" "www-a" {
   zone_id = "${aws_route53_zone.private.zone_id}"
   name    = "chef-server"
   type    = "A"
   ttl = "60"
   records = ["54.165.27.137"]
}
