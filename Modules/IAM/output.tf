output "aws_iam_instance_profile" {
    description = "name of ec2 iam instace profile"
    value = aws_iam_instance_profile.my_launch_template_instance_profile.name
}

output "s3_policy" {
  value = aws_iam_policy.s3_policy.arn
}

output "rds_policy" {
  value = aws_iam_policy.rds_policy.arn
}
output "ssm_policy"{
  value = aws_iam_policy.ssm_policy.arn
}
