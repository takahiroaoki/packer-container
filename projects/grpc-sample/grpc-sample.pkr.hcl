packer {
  required_version = ">= 1.11.2"
  required_plugins {
    amazon = {
      source  = "github.com/hashicorp/amazon"
      version = "~> 1"
    }
    goss = {
      version = "~> 3.2"
      source  = "github.com/YaleUniversity/goss"
    }
  }
}

locals {
  project   = "grpc-sample"
  timestamp = formatdate("YYYYMMDDhhmmss", timestamp())
}

variable "version" {
  type    = string
  default = "0.0.0"
}

source "amazon-ebs" "grpc-sample" {
  ami_name              = "${local.project}-ami-${var.version}"
  profile               = "packer"
  instance_type         = "t2.micro"
  region                = "ap-northeast-1"
  source_ami            = "ami-00c79d83cf718a893"
  ssh_username          = "ec2-user"
  force_deregister      = true
  force_delete_snapshot = true

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
    "source.amazon-ebs.grpc-sample"
  ]
  provisioner "file" {
    source      = "./resources/"
    destination = "/home/ec2-user/"
  }
  provisioner "shell" {
    inline = [
      "sudo mv /home/ec2-user/grpc-sample /usr/local/bin",
      "sudo mv /home/ec2-user/grpc-sample.service /etc/systemd/system",
      "sudo chmod 0111 /usr/local/bin/grpc-sample"
    ]
  }
  // server side test
  provisioner "goss" {
    pause_before = "10s"
    skip_install = false
    tests = [
      "./goss.yml"
    ]
    remote_path = "/tmp/goss"
    goss_file   = "goss.yml"
    use_sudo    = true
  }
  provisioner "shell" {
    inline = [
      "rm -rf /tmp/goss",
      "rm -rf /tmp/goss-*"
    ]
  }
}
