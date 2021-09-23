#!/bin/bash
# Script used for EC2 instance first boot

# # Basic packages
# yum update -y
# yum install git -y

# # Install and configura docker
# amazon-linux-extras install docker
# service docker start
# usermod -a -G docker ec2-user

# # Install kubectl
# curl -LO "https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl"
# chmod +x ./kubectl
# sudo mv ./kubectl /usr/local/bin/kubectl

# # Install minikube and start it
# curl -Lo minikube https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
# chmod +x minikube
# sudo mv minikube /usr/local/bin/

# # Create aliases
# echo "alias k=kubectl" >> ~/.bashrc
# source ~/.bashrc

yum update -y
yum install -y httpd
systemctl start httpd
systemctl enable httpd
echo "<h1>Hello World from $(hostname -f)</h1>" > /var/www/html/index.html