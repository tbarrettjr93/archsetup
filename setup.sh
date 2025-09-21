#!/bin/bash

# Simple Arch Linux Security Tools Setup
# Run: bash setup.sh

echo "=== Starting Security Tools Installation ==="
echo "This will take 15-20 minutes. Enter sudo password when prompted."

# Update system
sudo pacman -Syu --noconfirm

# Install core packages
sudo pacman -S --needed ruby 7zip john nmap rustscan veracrypt chromium nano git wget openssh docker docker-compose base-devel python-pipx sqlmap krb5 --noconfirm

# Create tools & misc directory
mkdir -p ~/tools
mkdir -p ~/misc

# Setup Docker
sudo systemctl enable --now docker
sudo usermod -aG docker $USER

# Install YAY
git clone https://aur.archlinux.org/yay.git /tmp/yay
cd /tmp/yay && makepkg -si --noconfirm && cd .. && rm -rf /tmp/yay


# Install AUR packages
yay -S --noconfirm burpsuite-pro responder blesh

# Modify bashrc to enable ble.sh (syntax highlighting + completion/suggestions)
echo '[[ $- == *i* ]] && source /usr/share/blesh/ble.sh' >> ~/.bashrc

# Setup pipx
pipx ensurepath

# Install pipx packages
pipx install git+https://github.com/blacklanternsecurity/impacket
pipx install git+https://github.com/blacklanternsecurity/certipy
pipx install git+https://github.com/blacklanternsecurity/bloodhound.py@bloodhound-ce
pipx install git+https://github.com/blacklanternsecurity/netexec
pipx install bbot
pipx install git+https://github.com/blacklanternsecurity/trevorproxy
pipx install git+https://github.com/blacklanternsecurity/trevorspray
pipx install bloodyAD

# Download BBOT module dependencies 

~/.local/bin/bbot --install-all-deps

# Setup BloodHound CE
mkdir -p ~/tools/bloodhound-ce
cd ~/tools/bloodhound-ce
curl -L https://ghst.ly/getbhce -o docker-compose.yml

# install evil-winrm
gem install evil-winrm
gem install csv
echo 'export PATH=$HOME/.local/share/gem/ruby/3.4.0/bin:$PATH' >> .bashrc

echo
echo "=== Installation Complete! ==="
echo
echo "NEXT STEPS:"
echo "1. LOG OUT and LOG BACK IN"
echo "2. Hack away"
echo
echo "TOOLS READY:"
echo "  • 7zip"
echo "  • john"
echo "  • nmap"
echo "  • rustscan"
echo "  • veracrypt"
echo "  • chromium"
echo "  • nano"
echo "  • git"
echo "  • wget"
echo "  • openssh"
echo "  • docker"
echo "  • docker-compose"
echo "  • pipx"
echo "  • impacket collection"
echo "  • certipy"
echo "  • bloodyAD"
echo "  • trevorspray"
echo "  • trevorproxy"
echo "  • BBOT"
echo
echo "BLOODHOUND CE: cd tools/bloodhound, docker compose pull && docker compose up, http://localhost:8080"
echo "TOOLS DIR: ~/tools"
echo
echo "To update later:"
echo "  sudo pacman -Syu"
echo "  yay -Syu"
echo "  pipx upgrade-all"
