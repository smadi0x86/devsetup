#!/bin/bash
set -e

# Install Python 3 and pip
echo "[+] Installing Python 3 and pip..."
sudo apt update -y
sudo apt install -y python3 python3-pip

# Install Go (golang)
GO_VERSION="1.24.2"
echo "[+] Installing Go $GO_VERSION..."
wget -q "https://go.dev/dl/go${GO_VERSION}.linux-amd64.tar.gz" -O /tmp/go.tar.gz
sudo rm -rf /usr/local/go
sudo tar -C /usr/local -xzf /tmp/go.tar.gz
rm /tmp/go.tar.gz

# Add Go to PATH permanently
if ! grep -q 'export PATH=.*go/bin' ~/.bashrc; then
    echo 'export PATH=$PATH:/usr/local/go/bin' >> ~/.bashrc
fi
if ! grep -q 'export PATH=.*go/bin' ~/.zshrc; then
    echo 'export PATH=$PATH:/usr/local/go/bin' >> ~/.zshrc
fi
export PATH=$PATH:/usr/local/go/bin

# Install Node.js with pnpm using NVM
echo "[+] Installing Node.js and pnpm via NVM..."
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.2/install.sh | bash

export NVM_DIR="$HOME/.nvm"
. "$NVM_DIR/nvm.sh"

nvm install 22
nvm use 22

corepack enable pnpm

echo "[+] Installed versions:"
echo "    Python: $(python3 --version)"
echo "    Pip: $(pip3 --version)"
echo "    Go: $(go version)"
echo "    Node: $(node -v)"
echo "    pnpm: $(pnpm -v)"

echo "[+] ✅ Programming languages setup complete!"
