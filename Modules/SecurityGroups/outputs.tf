output "elb" {
    description = "output of loadbalancer security group id"
    value =aws_security_group.elb.id
}
output "asg" {
    description = "output of auto scaling group security group id"
    value = aws_security_group.asg.id

}
output "rds" {
    description = "output of RDS security group id "
    value = aws_security_group.rds.id

}