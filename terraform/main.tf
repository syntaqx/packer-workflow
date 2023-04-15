variable "ami_id" {
  type = string
}

resource "aws_instance" "app_server" {
  instance_type = "t2.micro"
  ami           = var.ami_id
}
