resource "aws_launch_template" "launch_template" {
    name_prefix   = "${var.vpc_name}-launch_template"
    image_id      = var.image_id
    instance_type = var.instance_type
    key_name      = var.key

    monitoring {
        enabled = true
    }

    network_interfaces {
        associate_public_ip_address = false
        device_index                = 0  # Unique index for each interface
        network_card_index          = 0  # Unique index for each interface
        subnet_id                   = var.private_subnets[0]  # Subnet of 1st AZ ID
        security_groups             = [var.asg]  # Security group ID
    }

    iam_instance_profile {
        name = var.aws_iam_instance_profile
    }

    user_data = base64encode(templatefile("${path.module}/userdata.sh", {
        db_instance_endpoint = "${var.db_instance_endpoint}"
        username             = "${var.username}"
        password             = "${var.password}"
    }))


}
