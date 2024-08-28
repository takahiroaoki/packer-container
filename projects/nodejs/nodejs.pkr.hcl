locals {
  project = "nodejs"
}

variable "version" {
  type    = string
  default = "undefined"
}

source "amazon-ebs" "nodejs-ami" {
  ami_name      = "${local.project}-ami"
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
    "source.amazon-ebs.${local.project}-ami"
  ]
}