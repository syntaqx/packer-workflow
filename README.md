# Packer & Docker Workflow Example

This project demonstrates a very simple build and release system that leverages
both [Docker](https://www.docker.com/) and [Packer](https://www.packer.io/) to
achieve to build immutable artifacts that can be deployed easily on EC2.

## Docker

The actual _app_ runtime is containerized using Docker, which allows engineers
a way to easily manage the expectations of the application.

## Packer

Packer is the operational runtime _for_ Docker. An AMI is built which is capable
of starting the app as a Docker Service when the machine is deployed.

## Deployment

> WIP

Deployment is very simple in that the AMI (The `ami_id` is output from the
packer build job) needs to be started. This can be done on a singular EC2
image, or via an Auto-Scaling group.
