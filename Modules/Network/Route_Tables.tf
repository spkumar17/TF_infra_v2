resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.myvpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  
  tags = {
    Name        = "${var.vpc_name}-pub_rt"
    Owner       = "Prasanna Kumar"
    environment = "${var.environment}"
  }
}


resource "aws_route_table" "private_rt" {
    count = length("${aws_nat_gateway.natgw.*.id}")
    vpc_id = aws_vpc.myvpc.id
    
    route {
        cidr_block = "0.0.0.0/0"
        nat_gateway_id = element("${aws_nat_gateway.natgw.*.id}",count.index)
  }

  
  tags = {
    Name        = "${var.vpc_name}-pri_rt"
    Owner       = "Prasanna Kumar"
    environment = "${var.environment}"
  }
}


resource "aws_route_table" "db_rt" {
    count = length("${aws_nat_gateway.natgw.*.id}")
    vpc_id = aws_vpc.myvpc.id
    
    route {
        cidr_block = "0.0.0.0/0"
        nat_gateway_id = element("${aws_nat_gateway.natgw.*.id}",count.index)
  }

  
  tags = {
    Name        = "${var.vpc_name}-db_rt"
    Owner       = "Prasanna Kumar"
    environment = "${var.environment}"
  }
}

#route table associating
resource "aws_route_table_association" "Public_subnet_association" {
    count = length(var.public_subnet_cidr)
    subnet_id = element("${aws_subnet.public_subnets.*.id}",count.index)
    route_table_id = aws_route_table.public_rt.id
 
}

resource "aws_route_table_association" "Private_subnet_association" {
    count = length(var.private_subnet_cidr)
    subnet_id = element("${aws_subnet.private_subnets.*.id}",count.index)
    route_table_id = aws_route_table.private_rt[0].id  # All use the same route table
}


resource "aws_route_table_association" "db_subnet_association" {
    count = length(var.private_subnet_cidr)
    subnet_id = element("${aws_subnet.db_subnets.*.id}",count.index)
    route_table_id = aws_route_table.db_rt[1].id  # All use the same route table
}
