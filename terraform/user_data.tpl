#!/bin/bash
set -e

# Install Docker
yum update -y
amazon-linux-extras install docker -y
systemctl enable docker
systemctl start docker

# Install AWS CLI v2
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install

# Authenticate Docker to ECR
REGION="ap-south-1"
aws ecr get-login-password --region $REGION | docker login --username AWS --password-stdin ${image_url%/*}

# Pull and run Strapi
docker run -d -p 1337:1337 --name strapi ${image_url}
