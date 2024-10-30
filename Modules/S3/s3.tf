resource "aws_s3_bucket" "vpc_flow_logs_bucket" {
  bucket = "myvpcflowlogss-akakaka"

  tags = {
    Name        = "VPC Flow Logs"
    Environment = var.environment
  }
}
