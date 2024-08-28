#/bin/bash

sudo yum update -y
sudo yum install -y nginx-1:1.24.0-1.amzn2023.0.2

sudo mv -b /home/ec2-user/index.html /usr/share/nginx/html/

sudo systemctl enable nginx
sudo systemctl start nginx