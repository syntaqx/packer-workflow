#!/usr/bin/env bash

# Update package lists
sudo apt-get update

# Install nginx
sudo apt install -y nginx
sudo ufw allow 'Nginx HTTP'

# Install Ubuntu's universe repository, which includes free and open-source
# software maintained by the Ubuntu community, before installing the php-fpm.
sudo add-apt-repository universe

# Install the PHP FPM
sudo apt install -y php-fpm php-mysql

# Check that nginx is running
sudo systemctl status nginx
