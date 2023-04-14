#!/usr/bin/env bash
set -aueo pipefail

function wait_for_apt() {
  while fuser /var/{lib/{dpkg,apt/lists},cache/apt/archives}/lock >/dev/null 2>&1; do
    echo "Waiting on apt.."
    sleep 2
  done
}

wait_for_apt

# Update apt package index
sudo apt-get update

# Install packages for automatic (unattended) security
apt-get install -y apt-utils software-properties-common unattended-upgrades apt-listchanges jq

# Install packages to allow apt to use a repository over HTTPS
sudo apt-get install -y apt-transport-https ca-certificates curl gnupg lsb-release

# Install service requirements
sudo apt-get install -y nginx
