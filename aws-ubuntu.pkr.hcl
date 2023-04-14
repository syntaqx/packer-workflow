packer {
  required_plugins {
    amazon = {
      version = ">= 0.0.2"
      source  = "github.com/hashicorp/amazon"
    }
  }
}

variable "aws_region" {
  type    = string
  default = "us-east-1"
}

variable "ami_prefix" {
  type    = string
  default = "classic-example"
}

source "amazon-ebs" "ubuntu" {
  region = "${var.aws_region}"

  source_ami_filter {
    filters = {
      virtualization-type = "hvm"
      name                = "ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"
      root-device-type    = "ebs"
    }
    owners      = ["099720109477"]
    most_recent = true
  }

  instance_type  = "t2.small"
  ssh_username   = "ubuntu"
  ssh_agent_auth = false

  ami_name    = "${var.ami_prefix}-ubuntu-{{timestamp}}"
  ami_regions = ["${var.aws_region}"]
}

build {
  name = "bootstrap"
  sources = [
    "source.amazon-ebs.ubuntu"
  ]

  provisioner "shell" {
    script = ".classic/bootstrap.sh"
  }
}
