#!/bin/bash

sudo apt update
sudo apt-get install stress
#stress --cpu 8 --io 4 --vm 2 --vm-bytes 128M --timeout 10s
sudo snap install docker
sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

cat <<EOL > docker-compose.yml
version: '3.8'

services:
  wordpress:
    image: wordpress:latest
    ports:
      - 80:80
    restart: always
    environment:
      - WORDPRESS_DB_HOST=${aws_rds_cluster_endpoint}
      - WORDPRESS_DB_USER=${database_username}
      - WORDPRESS_DB_PASSWORD=${database_user_password}
      - WORDPRESS_DB_NAME=sampledbawab
      - WORDPRESS_ADMIN_USER=awab
      - WORDPRESS_ADMIN_PASSWORD=awabamjad
      - WORDPRESS_ADMIN_EMAIL=awabamjid@gmail.com
EOL

# Wait for Docker client to be running
while ! docker info > /dev/null 2>&1; do
    echo "Waiting for Docker to start..."
    sleep 1
done
sudo docker-compose up -d
