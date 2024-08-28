#/bin/bash

sudo yum update -y
sudo yum install -y nginx

sudo mv -b /home/ec2-user/index.html /usr/share/nginx/html/

sudo systemctl enable nginx