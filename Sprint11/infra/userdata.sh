#!/bin/bash
sudo snap install aws-cli --classic
aws s3 cp s3://apptestawab/sample.txt /home/ubuntu