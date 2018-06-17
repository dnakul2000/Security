provider "aws" {
 access_key = "aws_access_key_id"
 secret_key = "aws_secret_access_key_id"
 region = "us-east-1"
}


resource "aws_instance" "deshmukh" {
 ami = "${lookup(var.amis,var.region)}"
 key_name = "${var.key_name}"
 vpc_security_group_ids = ["${aws_security_group.ec2.id}"]
 source_dest_check = false
 instance_type = "t2.xlarge"
 user_data "${data.template_file.init.rendered}"
}


resource "aws_security_group" "ec2" {
  name = "deshmukh example"
  ingress {
    from_port = 8080
    to_port = 8080
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}


data "template_file" "init"{
  template = "${file("init.sh")}"
}
