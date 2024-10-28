output vpc_name {
  value       = var.vpc_name
}

output environment {
  value       = var.environment
}

output "igw" {
    value = aws_internet_gateway.igw
}

output "vpc_id"{
    value = aws_vpc.myvpc.id
}
output "public_subnets"{
    value = "${aws_subnet.public_subnets.*.id}"

}
output "private_subnets"{
    value = "${aws_subnet.private_subnets.*.id}"
 
}
output "database_subnets" {
  value =  "${aws_subnet.db_subnets.*.id}"
  
}