#!/bin/bash

# Set locale
locale-gen en_US.UTF-8
update-locale LANG=en_US.UTF-8
echo 'export LANG=en_US.UTF-8' >> ~/.bashrc
echo 'export LANGUAGE=en_US:en' >> ~/.bashrc
echo 'export LC_ALL=en_US.UTF-8' >> ~/.bashrc
source ~/.bashrc
apt update && apt install -y locales
echo 'export TERM=xterm-256color' >> ~/.bashrc
source ~/.bashrc
dpkg-reconfigure locales
echo "Locale and terminal settings have been configured. Please restart your terminal session."

# Install required packages
apt update && apt upgrade -y
apt install ca-certificates curl sudo gdu tree wget htop telnet traceroute dnsutils tmux rsync ufw -y

# Node exporter
curl -sSfL https://raw.githubusercontent.com/carlocorradini/node_exporter_installer/main/install.sh | sh -

# Docker install
install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/debian/gpg -o /etc/apt/keyrings/docker.asc
chmod a+r /etc/apt/keyrings/docker.asc
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/debian \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  tee /etc/apt/sources.list.d/docker.list > /dev/null
apt update && apt install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin -y

# Portainer Agent
docker run -d -p 9001:9001 --name portainer_agent --restart=always --log-opt max-size=5m --log-opt max-file=3 -v /var/run/docker.sock:/var/run/docker.sock -v /var/lib/docker/volumes:/var/lib/docker/volumes portainer/agent:latest
