resource "aws_s3_bucket" "vpc_flow_logs_bucket" {
  bucket = "${var.vpc_name}_myvpcflowlogss_${var.environment}"

  tags = {
    Name        = "VPC Flow Logs"
    Environment = var.environment
  }
}
