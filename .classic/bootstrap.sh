#!/usr/bin/env bash
set -aueo pipefail

# Update apt package index
sudo apt-get update

# Install packages for automatic (unattended) security
apt-get install -y apt-utils software-properties-common unattended-upgrades apt-listchanges jq

# Install packages to allow apt to use a repository over HTTPS
sudo apt-get install -y apt-transport-https ca-certificates curl gnupg lsb-release

# Install service requirements
sudo apt-get install -y nginx
