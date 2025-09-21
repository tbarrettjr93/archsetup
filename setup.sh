#!/bin/bash

# Simple Arch Linux Security Tools Setup
# Run: bash setup-security-tools-simple.sh

echo "=== Starting Security Tools Installation ==="
echo "This will take 10-15 minutes. Enter sudo password when prompted."

# Update system
sudo pacman -Syu --noconfirm

# Install core packages
sudo pacman -S --needed 7zip john chromium nano zsh zsh-syntax-highlighting git wget openssh docker docker-compose base-devel python-pipx --noconfirm

# Download .zshrc from GitHub
echo "Downloading .zshrc from GitHub..."
curl -L https://raw.githubusercontent.com/tbarrettjr93/archsetup/refs/heads/main/.zshrc -o ~/.zshrc
chmod 644 ~/.zshrc
echo "✓ .zshrc downloaded from GitHub"

# Set zsh as default shell
chsh -s /usr/bin/zsh || sudo usermod -s /usr/bin/zsh $USER

# Create tools directory
mkdir -p ~/tools

# Setup SSH
sudo systemctl enable --now sshd
sudo sed -i 's/#PermitRootLogin.*/PermitRootLogin no/' /etc/ssh/sshd_config
sudo sed -i 's/#PasswordAuthentication.*/PasswordAuthentication yes/' /etc/ssh/sshd_config
sudo systemctl restart sshd

# Setup Docker
sudo systemctl enable --now docker
sudo usermod -aG docker $USER

# Install YAY
if ! command -v yay; then
    git clone https://aur.archlinux.org/yay.git /tmp/yay
    cd /tmp/yay && makepkg -si --noconfirm && cd .. && rm -rf /tmp/yay
fi

# Install AUR packages
yay -S --noconfirm burpsuite-pro responder

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

# Setup BloodHound CE
mkdir -p ~/tools/bloodhound-ce
cd ~/tools/bloodhound-ce
curl -L https://ghst.ly/getbhce -o docker-compose.yml

echo
echo "=== Installation Complete! ==="
echo
echo "NEXT STEPS:"
echo "1. LOG OUT and LOG BACK IN"
echo "2. Your .zshrc should be ready from GitHub"
echo
echo "TOOLS READY:"
echo "  • burpsuite pro"
echo "  • Responder.py -h"
echo "  • nxc -h"
echo "  • impacket-GetNPUsers -h"
echo "  • Certipy -h"
echo
echo "BLOODHOUND CE: http://localhost:8080"
echo "TOOLS DIR: ~/tools"
echo
echo "To update later:"
echo "  sudo pacman -Syu"
echo "  yay -Syu"
echo "  pipx upgrade-all"
