packer {
  required_plugins {
    amazon = {
      source  = "github.com/hashicorp/amazon"
      version = "~> 1"
    }
  }
}

locals {
  project = "nginx"
}

variable "version" {
  type    = string
  default = "undefined"
}

source "amazon-ebs" "nginx" {
  ami_name      = "${local.project}-ami-${var.version}"
  profile       = "packer"
  instance_type = "t2.micro"
  region        = "ap-northeast-1"
  source_ami    = "ami-00c79d83cf718a893"
  ssh_username  = "ec2-user"

  launch_block_device_mappings {
    device_name = "/dev/xvda"
    volume_size = 8
  }
  tags = {
    Version       = "${var.version}"
    SourceAMIID   = "{{ .SourceAMI }}"
    SourceAMIName = "{{ .SourceAMIName }}"
  }
}

build {
  sources = [
    "source.amazon-ebs.nginx"
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