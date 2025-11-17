# Development Tools

## Prerequisites

```bash
# Install Homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Install Xcode Command Line Tools
xcode-select --install

# Install bash
brew install bash

# Confirm the path
/opt/homebrew/bin/bash --version

# Add to allowed shells
sudo nano /etc/shells
# Insert /opt/homebrew/bin/bash at the top

# Change default login shell
chsh -s /opt/homebrew/bin/bash

# Make sure eval "$(/opt/homebrew/bin/brew shellenv)" is in .profile

# Restart terminal and confirm
echo $SHELL
which bash
bash --version
```

## Base System Tools

```bash
brew bundle install
```

## Core Tools (Used in .bashrc)

### Starship Prompt

```bash
curl -sS https://starship.rs/install.sh | sh
```

## Development Tools

### Languages

#### Go Language

```bash
# Check latest: https://golang.org/dl/
wget https://go.dev/dl/go1.21.5.darwin-arm64.tar.gz
sudo rm -rf /usr/local/go
sudo tar -C /usr/local -xzf go1.21.5.darwin-arm64.tar.gz
rm go1.21.5.darwin-arm64.tar.gz
```

#### Node.js

Node.js is installed via Brewfile (`brew bundle install`).

```bash
# Install yarn globally after Node.js is installed
npm install --global yarn
```

### Editors

#### Neovim

```bash
# Latest stable release
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-macos-arm64.tar.gz
sudo rm -rf /opt/nvim-macos-arm64
sudo mkdir -p /opt/nvim-macos-arm64
sudo chmod a+rX /opt/nvim-macos-arm64
sudo tar -C /opt -xzf nvim-macos-arm64.tar.gz
sudo ln -sf /opt/nvim-macos-arm64/bin/nvim /usr/local/bin/nvim
rm nvim-macos-arm64.tar.gz
```

### Containers

#### Docker

```bash
# Install docker desktop from https://www.docker.com/products/docker-desktop
```

#### Kubernetes

```bash
# kubectl
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/darwin/arm64/kubectl"
sudo install -o root -g wheel -m 0755 kubectl /usr/local/bin/kubectl
rm kubectl

```

## Update All Packages

```bash
brew update && brew upgrade && brew cleanup
```
