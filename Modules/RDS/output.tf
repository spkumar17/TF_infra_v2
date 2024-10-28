output "db_instance_endpoint" {
  value = aws_db_instance.instance.endpoint
}

output "database_name" {
  value = aws_db_instance.instance.db_name

}

output "username" {
  value = aws_db_instance.instance.username
}

output "password" {
  value = aws_db_instance.instance.password
}