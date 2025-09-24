#!/bin/bash
sudo yum update -y
sudo yum install -y docker

# Start and enable Docker
sudo systemctl enable docker
sudo systemctl start docker

# Create a custom network so containers can talk by name
docker network create strapi-net

# Start Postgres on custom network
docker run -d --name postgres-container \
  --network strapi-net \
  -e POSTGRES_USER=strapi \
  -e POSTGRES_PASSWORD=strapi \
  -e POSTGRES_DB=strapi \
  -p 5432:5432 \
  postgres:15-alpine

# Wait for Postgres to be ready (instead of fixed sleep)
echo "Waiting for Postgres to start..."
until docker exec postgres-container pg_isready -U strapi; do
  sleep 3
done

# Run Strapi on the same network
docker run -d --name strapi-container \
  --network strapi-net \
  -e DATABASE_CLIENT=postgres \
  -e DATABASE_NAME=strapi \
  -e DATABASE_HOST=postgres-container \
  -e DATABASE_PORT=5432 \
  -e DATABASE_USERNAME=strapi \
  -e DATABASE_PASSWORD=strapi \
  -p 1337:1337 \
  sairambadari/strapi:latest
