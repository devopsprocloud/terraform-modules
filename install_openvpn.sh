#!/bin/bash
set -e

# Update system and install EPEL
dnf update -y
dnf install -y https://dl.fedoraproject.org/pub/epel/epel-release-latest-9.noarch.rpm

# Install required tools
dnf install -y curl wget bind-utils

# Download and run Angristan OpenVPN install script
wget https://raw.githubusercontent.com/angristan/openvpn-install/master/openvpn-install.sh
chmod +x openvpn-install.sh

# Create a non-interactive input file for the script
cat <<EOF | sudo bash openvpn-install.sh
1
1194
2
1
client
EOF
