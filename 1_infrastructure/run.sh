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
wget https://aws-codedeploy-ap-southeast-1.s3.ap-southeast-1.amazonaws.com/latest/install
chmod +x ./install
sudo ./install auto
sudo service codedeploy-agent start

# Cole repository
git clone https://github.com/EnriquePernia/DevOps_Test.git