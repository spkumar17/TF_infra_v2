resource "aws_launch_template" "launch_template" {
    name_prefix   = "${var.vpc_name}-launch_template"
    image_id = var.image_id
    instance_type = var.instance_type
    key_name =var.key
    monitoring {
        enabled = true
    }

    network_interfaces {
        associate_public_ip_address = false
        device_index                = 0  # need to add Unique index for each interface
        network_card_index          = 0  # need to add Unique index for each interface
        subnet_id                   = var.private_subnets[0] #subnet of 1 frist az ID
        security_groups             = [var.asg]# security group ID
    }
    iam_instance_profile {
        name =var.aws_iam_instance_profile
        }
    user_data = base64encode(<<-EOF
                #!/bin/bash
                # Update packages and install Docker
                sudo apt-get update -y
                sudo apt-get install -y docker.io

                # Start Docker and enable it to start at boot
                sudo systemctl start docker
                systemctl enable docker

                # Add the current user to the Docker group
                sudo usermod -aG docker $USER

                # Pull the Docker image
                docker pull prasannakumarsinganamalla431/petclinic:8

                # Run the Docker container with environment variables for the RDS connection
                docker run -d --name petclinic_app -p 8080:8080 \
                    -e DB_HOST="${var.db_instance_endpoint}" \
                    -e DB_PORT="3306" \
                    -e DB_NAME="${var.database_name}" \
                    -e DB_USER="${var.username}" \
                    -e DB_PASSWORD="${var.password}" \
                    prasannakumarsinganamalla431/petclinic:8

                EOF
            )
    
}   
  
