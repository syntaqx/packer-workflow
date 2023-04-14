#!/usr/bin/env bash

# Update apt package index
sudo apt-get update

# Install packages to allow apt to use a repository over HTTPS
sudo apt-get install -y apt-transport-https ca-certificates curl gnupg lsb-release

# Add Docker's official GPG key
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

# Add Docker repository to apt sources
echo "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# Update apt package index again
sudo apt-get update

# Install Docker
sudo apt-get install -y docker-ce docker-ce-cli containerd.io

# Add current user to docker group to avoid using sudo
sudo usermod -aG docker $USER

# Create systemd service file for Docker container
cat <<EOF | sudo tee /etc/systemd/system/example.service > /dev/null
[Unit]
Description=My Docker Container

[Service]
Restart=always
ExecStart=/usr/bin/docker run -p 80:80 nginx

[Install]
WantedBy=multi-user.target
EOF

# Reload systemd
sudo systemctl daemon-reload

# Start Docker container service
# sudo systemctl start example.service

# Enable Docker container service to start at boot time
sudo systemctl enable example.service
