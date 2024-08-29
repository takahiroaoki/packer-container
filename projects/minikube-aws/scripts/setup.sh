#/bin/bash

# Git
echo "==========="
echo "Install Git"
echo "==========="
sudo dnf update
sudo dnf install -y git-2.40.1-1.amzn2023.0.3.x86_64

# Docker
echo "=============="
echo "Install Docker"
echo "=============="
sudo dnf install -y docker-25.0.6-1.amzn2023.0.1.x86_64
sudo systemctl enable docker
sudo systemctl start docker
sudo gpasswd -a ec2-user docker

# Minikube
echo "================"
echo "Install Minikube"
echo "================"
curl -LO https://storage.googleapis.com/minikube/releases/v1.33.1/minikube-linux-amd64
sudo install minikube-linux-amd64 /usr/local/bin/minikube && rm minikube-linux-amd64
minikube config set kubernetes-version v1.29.4
minikube config set driver docker
echo 'alias kubectl="minikube kubectl --"' >> ~/.bashrc