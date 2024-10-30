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

    user_data = base64encode(<<-EOF
                #!/bin/bash
                set -e  # Exit immediately if a command exits with a non-zero status

                # Update packages and install Nginx
                sudo apt-get update -y
                sudo apt-get install -y nginx

                # Start and enable Nginx
                sudo systemctl start nginx
                sudo systemctl enable nginx

                # Set up a basic HTML page
                echo "<html><body><h1>Welcome to Nginx on EC2</h1></body></html>" | sudo tee /var/www/html/index.html

                # Restart Nginx to ensure changes are applied
                sudo systemctl restart nginx
                EOF
            )
}
