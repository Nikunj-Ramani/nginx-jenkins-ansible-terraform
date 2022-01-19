terraform {
  required_version = "1.1.3"
}

provider "aws" {
    region=var.region
    profile=var.profile
}

resource "aws_instance" "site" {
    ami = "ami-04505e74c0741db8d"
    instance_type = "t2.micro"
    key_name = "nikunj-patel-9691-ec2-2022"
    vpc_security_group_ids = ["sg-01dd5ac3568ec2b43","sg-03eb04772c6ea415c"]
        tags = {
            Name = var.name
            group = var.group
        }
}

