# alb resource 

resource "aws_lb" "alb" {
  name               = "${var.vpc_name}-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [var.alb]
  subnets            = [var.public_subnets[0],var.public_subnets[1]]

  enable_deletion_protection = false

  tags = {
    name = "${var.vpc_name}-alb"
    environment = "${var.environment}"

  }
}
