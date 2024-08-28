packer {
  required_plugins {
    amazon = {
      source  = "github.com/hashicorp/amazon"
      version = "~> 1"
    }
  }
}

source "amazon-ebs" "amzn2-nginx" {
  ami_name      = "hello-nginx.ami"
  profile       = "packer"
  instance_type = "t2.micro"
  region        = "ap-northeast-1"
  source_ami    = "ami-00c79d83cf718a893"
  ssh_username  = "ec2-user"
}

build {
  sources = [
    "source.amazon-ebs.amzn2-nginx"
  ]
  provisioner "file" {
    source      = "./resources/index.html"
    destination = "/home/ec2-user/"
  }
  provisioner "shell" {
    // inline = [
    //   "sudo yum update -y",
    //   "sudo yum install -y nginx",
    //   "sudo mv -b /home/ec2-user/index.html /usr/share/nginx/html/",
    //   "sudo systemctl enable nginx"
    // ]
    scripts = [
      "./scripts/initialize.sh"
    ]
  }
}