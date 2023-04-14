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

> WIP

Deployment is very simple in that you must only take the `ami_id` provided from
the `build` stage and either deploy a single EC2 image or roll many out using
an autoscaling group.
