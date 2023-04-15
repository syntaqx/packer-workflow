resource "aws_instance" "app_server" {
  instance_type = "t2.micro"
  ami           = var.ami_id
}

# TODO: This should be done via an ASG so we replace existing instances rather
# than always deploying a new one.
