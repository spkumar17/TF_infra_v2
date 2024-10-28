 
resource "aws_subnet" "private_subnets" {
    count = length(var.AZs)
    vpc_id     = aws_vpc.myvpc.id
    availability_zone = element(var.AZs,count.index)
    cidr_block = element(var.private_subnet_cidr,count.index)
    map_public_ip_on_launch = false

  tags = {
    Name        = "${var.vpc_name}-private_subnet-${count.index}"
    Owner       = "Prasanna Kumar"
    environment = "${var.environment}"
  }
}


# resource "aws_subnet" "private_subnets" {
#     # Create 2 subnets per AZ
#     count = length(var.AZs) * 2

#     vpc_id     = aws_vpc.myvpc.id
#     availability_zone = element(var.AZs, floor(count.index / 2))  # Each AZ gets 2 subnets
#     cidr_block = element(var.private_subnet_cidr, count.index)     # Unique CIDR block for each subnet
#     map_public_ip_on_launch = true

#     tags = {
#       Name = "prisubnet-${count.index + 1}"   # Tag each subnet with a unique name
#       Owner       = "Prasanna Kumar"
#       environment = "${var.environment}"
#     }
# }
