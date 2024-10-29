
resource "aws_security_group" "elb" {
  name        = "${var.vpc_name}-elb-sg"
  description = "Allow all inbound traffic"
  vpc_id      = var.vpc_id

  dynamic "ingress" {
    for_each = var.service_ports_elb
    content {
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }

  dynamic "egress" {
    for_each = var.service_ports_elb
    content {
      from_port   = egress.value
      to_port     = egress.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }

  tags = {
    Name        = "${var.vpc_name}-elb-sg"
    environment = "${var.environment}"
  }
}

# Autoscaling group 
resource "aws_security_group" "asg" {
  name        = "${var.vpc_name}-asg-sg"
  description = "Allow all inbound traffic"
  vpc_id      = var.vpc_id

  dynamic "ingress" {
    for_each = var.service_ports_asg
    content {
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      security_groups = [aws_security_group.elb.id]

    }
  }

  dynamic "egress" {
    for_each = var.service_ports_asg
    content {
      from_port   = egress.value
      to_port     = egress.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }

  tags = {
    Name        = "${var.vpc_name}-asg-sg"
    environment = "${var.environment}"
  }
  depends_on = [aws_security_group.elb]

}


# RDS
resource "aws_security_group" "rds" {
  name        = "${var.vpc_name}-rds-sg"
  description = "Allow all inbound traffic"
  vpc_id      = var.vpc_id

  dynamic "ingress" {
    for_each = var.service_ports_rds
    content {
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      # Reference ASG security group ID
      security_groups = [aws_security_group.asg.id]
    }
  }

  dynamic "egress" {
    for_each = var.service_ports_rds
    content {
      from_port   = egress.value
      to_port     = egress.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }

  tags = {
    Name        = "${var.vpc_name}-rds-sg"
    environment = "${var.environment}"
  }
  depends_on = [aws_security_group.asg]

}