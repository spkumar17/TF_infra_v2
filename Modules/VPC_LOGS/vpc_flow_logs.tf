data "aws_iam_policy_document" "assume_role" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["vpc-flow-logs.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}

resource "aws_iam_role" "vpc_flow_logs" {
  name               = "vpc_flow_logs"
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
}

resource "aws_iam_role_policy_attachment" "attach_s3LOGS_policy" {
  role       = aws_iam_role.vpc_flow_logs.name
  policy_arn = var.s3_policy
}

resource "aws_flow_log" "flow_log" {
  iam_role_arn    = "${aws_iam_role.vpc_flow_logs.arn}"
  log_destination      = var.bucket_name  
  log_destination_type = "s3"
  traffic_type         = "ALL"
  vpc_id               = var.vpc_id

  tags = {
    Name = "VPC Flow Log"
  }
}