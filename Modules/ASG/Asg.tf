
resource "aws_autoscaling_group" "autoscaling_group" {
    name                      = "${var.vpc_name}-asg"
    max_size                  = var.max_size
    min_size                  = var.min_size
    health_check_grace_period = var.health_check_grace_period 
    health_check_type         = var.health_check_type
    desired_capacity          = var.desired_capacity
    force_delete              = true
    vpc_zone_identifier       = [var.private_subnets[0],var.private_subnets[1]]
    target_group_arns = [var.alb_target_group_arn]


    launch_template {
        id      = aws_launch_template.launch_template.id
        version = aws_launch_template.launch_template.latest_version
        }
    lifecycle {
        create_before_destroy = true
    }


}