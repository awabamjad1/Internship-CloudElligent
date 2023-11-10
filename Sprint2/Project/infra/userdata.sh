#!/bin/bash
sudo apt-get update
sudo snap install docker
sudo snap install aws-cli --classic
aws s3 cp s3://apptestawab/docker-compose.yml /home/ubuntu
sudo docker-compose -f /home/ubuntu/docker-compose.yml up