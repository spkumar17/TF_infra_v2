#public subnets 
resource "aws_subnet" "public_subnets" {
    count = length(var.AZs)
    vpc_id     = aws_vpc.myvpc.id
    availability_zone = element(var.AZs,count.index)
    cidr_block = element(var.public_subnet_cidr,count.index)
    map_public_ip_on_launch = true

  tags = {
    Name        = "${var.vpc_name}-public_subnet-${count.index}"
    Owner       = "Prasanna Kumar"
    environment = "${var.environment}"
  }
}


# if i want to create 2 subnets in each AZ's
# resource "aws_subnet" "public_subnets" {
#     # Create 2 subnets per AZ
#     count = length(var.AZs) * 2

#     vpc_id     = aws_vpc.myvpc.id
#     availability_zone = element(var.AZs, floor(count.index / 2))  # Each AZ gets 2 subnets
#     cidr_block = element(var.public_subnet_cidr, count.index)     # Unique CIDR block for each subnet
#     map_public_ip_on_launch = true

#     tags = {
#       Name = "pubsubnet-${count.index + 1}"   # Tag each subnet with a unique name
#     }
# }

# floor(count.index / 2)
# For count.index = 0, floor(0 / 2) =      0 (AZ 1: us-east-1a)
# For count.index = 1, floor(1 / 2) =      0 (AZ 1: us-east-1a)
# For count.index = 2, floor(2 / 2) =      1 (AZ 2: us-east-1b)
# For count.index = 3, floor(3 / 2) =      1 (AZ 2: us-east-1b)
# For count.index = 4, floor(4 / 2) =      2 (AZ 3: us-east-1c)
# For count.index = 5, floor(5 / 2) =      2 (AZ 3: us-east-1c)


