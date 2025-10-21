# smadi0x86 development setup

This repository automates the installation and configuration of my personal development environment on Debian-based systems (Ubuntu, WSL, Debian 12).

If you're wondering why I have 2 text editors (`emacs` and `nvim`), I use `nvim` for fast file editing and `emacs` for larger or more structured projects.

This is made to work on my own machines, if you face any problems you're alone :(

## Installation

Run this to clone and install everything (headless mode):

```bash
bash -c "$(curl -fsSL https://raw.githubusercontent.com/smadi0x86/devsetup/main/install.sh)" -- --headless
```
## Manual Installation

```bash
git clone https://github.com/smadi0x86/devsetup.git ~/devsetup
cd ~/devsetup
./install.sh
```

Run these locally to make git sign commits using SSH by default after adding a signing key to github:

```bash
# 1. Tell Git to use the SSH format for signing
git config --global gpg.format ssh

# 2. Specify the path to your public key file
git config --global user.signingkey /PATH/TO/YOUR/.ssh/id_ed25519.pub

# 3. Set Git to sign all commits by default instead of using "git commit -S -m"
git config --global commit.gpgsign true
```

## What it does?

- Symlinks dotfiles (Emacs, Neovim, Tmux) into your home directory
- Installs optional tools (Starship, Neovim from source, common packages)
- Prompts you to run extra setup scripts (e.g. security, langs, devops)
