resource "aws_eip" "nat_eips" {
  count = 2
  domain = "vpc"
}

resource "aws_nat_gateway" "natgw" {
    count = length("${aws_eip.nat_eips.*.id}")
    allocation_id = element("${aws_eip.nat_eips.*.id}",count.index)
    subnet_id     = element("${aws_subnet.public_subnets.*.id}",count.index)

  tags = {
    Name = "${var.vpc_name}-NAT-GW-${count.index}"
    Owner       = "Prasanna Kumar"
    environment = "${var.environment}"
  }
}