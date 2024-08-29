packer {
  required_version = ">= 1.11.2"
  required_plugins {
    amazon = {
      source  = "github.com/hashicorp/amazon"
      version = "~> 1"
    }
  }
}

locals {
  project   = "minikube-aws"
  timestamp = formatdate("YYYYMMDDhhmmss", timestamp())
}

variable "version" {
  type    = string
  default = "undefined"
}

source "amazon-ebs" "minikube-aws" {
  ami_name      = "${local.project}-ami-${var.version}"
  profile       = "packer"
  instance_type = "t2.medium"
  region        = "ap-northeast-1"
  source_ami    = "ami-00c79d83cf718a893"
  ssh_username  = "ec2-user"

  launch_block_device_mappings {
    device_name = "/dev/xvda"
    volume_size = 8
  }
  tags = {
    Version       = var.version
    Created       = local.timestamp
    SourceAMIID   = "{{ .SourceAMI }}"
    SourceAMIName = "{{ .SourceAMIName }}"
  }
}

build {
  sources = [
    "source.amazon-ebs.minikube-aws"
  ]
  provisioner "shell" {
    scripts = [
      "./scripts/setup.sh"
    ]
  }
}