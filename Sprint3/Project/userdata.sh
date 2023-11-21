#!/bin/bash
sudo apt-get update
sudo snap install docker
sudo docker pull awabamjad/wordreversalfrontend
sudo docker pull awabamjad/wordreversalbackend
sudo docker run -d -p 80:80 awabamjad/wordreversalfrontend
sudo docker run -d -p 5000:5000 awabamjad/wordreversalbackend
sudo apt-get install -y amazon-efs-utils
sudo mkdir /mnt/efs
sudo mount -t efs ${aws_efs_file_system.file_system.id}:/ /mnt/efs