resource "aws_s3_bucket" "vpc_flow_logs_bucket" {
  bucket = "myvpcflowlogss_${var.environment}"

  tags = {
    Name        = "VPC Flow Logs"
    Environment = var.environment
  }
}
