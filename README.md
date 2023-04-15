# Packer Deployment Example

This project demonstrates a very simple build and release system that leverages
[Packer](https://www.packer.io/) to build immutable artifacts that can easily
be deployed on EC2.

## Packer

Packer is used to execute the `.classic/bootstrap.sh` script, which allows full
customization of the runtime for a given application. This can be generic and
install all packages itself, start Docker, whatever is necessary.

A more complex project likely would want to include a [File provisioner](https://developer.hashicorp.com/packer/docs/provisioners/file)
to add source code for the runtime, or potentially even start a Docker container
so that the operational runtime and app runtimes are separate.

## Deployment

Deployment is very simple: Once an AMI is available, Terraform updates the
`aws_launch_template` and applies that update to an `aws_autoscaling_group`. The
Terraform code here is just an example of what an implementation looks like, and
likely isn't fully functional, but it's a good marker for what the project
should be doing. Additional work around things like VPC, subnets, and target
groups is necessary and are codified with placeholder values.
