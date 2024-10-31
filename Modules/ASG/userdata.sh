#!/bin/bash

# Update package repository and install Docker
sudo apt update -y
sudo apt install -y docker.io

# Enable Docker service on startup
sudo systemctl enable docker
sudo systemctl start docker

# Add the 'ubuntu' user to the Docker group (common for Ubuntu instances)
sudo usermod -aG docker $USER
sudo usermod -aG docker ssm-user

# Pull the latest version of the Docker image
sudo docker pull prasannakumarsinganamalla431/petclinic:8

# Run Docker container with environment variables (replace with your actual values from Terraform)
sudo docker run -d --name petclinic \
-e MYSQL_URL=jdbc:mysql://${db_instance_endpoint}/petclinic \
-e MYSQL_USER=${username} \
-e MYSQL_PASSWORD=${password} \
-p 80:80 \
prasannakumarsinganamalla431/petclinic:8
