variable "subnet_ids" {
  type = list(string)
  default = [
    "subnet-0a1b2c3d",
    "subnet-1a2b3c4d",
    "subnet-2a3b4c5d",
  ]
}

variable "target_group_arns" {
  type = list(string)
  default = [
    "arn:aws:elasticloadbalancing:us-east-1:123456789012:targetgroup/my-targets/73e2d6bc24d8a067",
  ]
}

resource "random_pet" "ami_random_name" {
  keepers = {
    ami_id = var.ami_id
  }
}

resource "aws_security_group" "example" {
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
}

resource "aws_launch_template" "example" {
  name_prefix   = "classic-example"
  image_id      = var.ami_id
  instance_type = "t2.micro"
  key_name      = "testing"

  vpc_security_group_ids = [aws_security_group.example.id]

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "example" {
  name_prefix         = "classic-example-${random_pet.ami_random_name.id}"
  vpc_zone_identifier = var.subnet_ids
  target_group_arns   = var.target_group_arns

  health_check_type         = "ELB"
  health_check_grace_period = 300
  default_cooldown          = 10

  min_size         = 4
  max_size         = 4
  desired_capacity = 4

  launch_template {
    id      = aws_launch_template.example.id
    version = aws_launch_template.example.latest_version
  }

  lifecycle {
    create_before_destroy = true
  }

  instance_refresh {
    strategy = "Rolling"
    preferences {
      min_healthy_percentage = 50
    }
    triggers = ["tag"]
  }
}
