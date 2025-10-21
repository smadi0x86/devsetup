#!/bin/bash

set -e

FONT_NAME="JetBrainsMono"
FONT_STYLE="JetBrainsMonoNerdFont-SemiBold.ttf"
FONT_URL="https://github.com/ryanoasis/nerd-fonts/releases/latest/download/JetBrainsMono.zip"
FONT_DIR="$HOME/.local/share/fonts"

install_nerd_font() {
    echo "[+] Installing JetBrainsMono Nerd Font (SemiBold)..."
    mkdir -p "$FONT_DIR"
    tmpdir=$(mktemp -d)
    cd "$tmpdir"

    wget "$FONT_URL" -O JetBrainsMono.zip
    unzip -o JetBrainsMono.zip "$FONT_STYLE" -d "$FONT_DIR"

    fc-cache -fv
    cd -
    rm -rf "$tmpdir"
    echo "[+] Font installed: $FONT_STYLE"
}

install_starship() {
    echo "[+] Installing Starship prompt..."
    curl -sS https://starship.rs/install.sh | sh -s -- -y

    echo "[+] Adding Starship to shell config..."

    SHELL_NAME=$(basename "$SHELL")

    case "$SHELL_NAME" in
        bash)
            STARSHIP_LINE='eval "$(starship init bash)"'
            grep -qxF "$STARSHIP_LINE" ~/.bashrc || echo "$STARSHIP_LINE" >> ~/.bashrc
            ;;
        *)
            echo "[!] Your shell ($SHELL_NAME) is not automatically supported. Please add Starship init manually."
            ;;
    esac
}

# Start installation
install_nerd_font
install_starship

echo "[+] Done! Please restart your terminal or source your shell config."