#!/bin/bash
set -e

# install docker
yum update -y || apt-get update -y
if command -v yum >/dev/null 2>&1; then
  yum install -y docker
else
  apt-get install -y docker.io
fi

systemctl enable docker
systemctl start docker

# AWS ECR login
aws configure set default.region ${region}
aws ecr get-login-password --region ${region} | docker login --username AWS --password-stdin ${account_id}.dkr.ecr.${region}.amazonaws.com

# Pull Strapi image with SHA tag
IMAGE_URI=${account_id}.dkr.ecr.${region}.amazonaws.com/${ecr_repo}:${image_tag}

# Stop existing container if any
if docker ps -a --format '{{.Names}}' | grep -q '^strapi-container$'; then
  docker rm -f strapi-container || true
fi

# Run container mapping host 80 -> container 1337
docker run -d --name strapi-container -p 80:1337 \
  -e NODE_ENV=production \
  -e DATABASE_CLIENT=sqlite \
  --restart unless-stopped \
  ${IMAGE_URI}
