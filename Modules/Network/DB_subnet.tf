resource "aws_subnet" "db_subnets" {
    count = length(var.AZs)
    vpc_id     = aws_vpc.myvpc.id
    availability_zone = element(var.AZs,count.index)
    cidr_block = element(var.db_subnet_cidr,count.index)
    map_public_ip_on_launch = false

  tags = {
    Name        = "${var.vpc_name}-DB_subnet-${count.index}"
    Owner       = "Prasanna Kumar"
    environment = "${var.environment}"
  }
}
