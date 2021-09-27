#!/bin/bash
# Script used for EC2 instance first boot

# Basic packages
yum update -y
yum install git -y

# Install and configura docker
amazon-linux-extras install docker
service docker start
usermod -a -G docker ec2-user

# Install codeDeploy agent
sudo yum update 
sudo yum install -y ruby
sudo yum install wget
wget https://aws-codedeploy-eu-west-1.s3.eu-west-1.amazonaws.com/latest/install
chmod +x ./install
sudo ./install auto
sudo service codedeploy-agent start

# Code repository
git clone https://github.com/EnriquePernia/DevOps_Test.git
cd DevOps_Test
cd 2_application
docker build -t go-app .
docker run -p 80:8080 go-app