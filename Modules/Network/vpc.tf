resource "aws_vpc" "myvpc" {
  cidr_block       = var.vpc_cidr_block
  instance_tenancy = "default"
  enable_dns_support =  true
  enable_dns_hostnames = true

  tags = {
    Name        = "${var.vpc_name}"
    Owner       = "Prasanna Kumar"
    environment = "${var.environment}"
  }
}

