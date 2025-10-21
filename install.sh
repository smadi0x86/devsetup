#!/bin/bash

set -e

# Auto-clone repo if not in repo root
if [ ! -f install.sh ] && ! git rev-parse --is-inside-work-tree &>/dev/null; then
    echo "[INFO] Cloning devsetup repo into ~/devsetup..."
    git clone https://github.com/smadi0x86/devsetup.git ~/devsetup
    cd ~/devsetup || exit 1
fi

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DOTFILES_DIR="$REPO_DIR/dotfiles"
SCRIPTS_DIR="$REPO_DIR/scripts"
PACKAGES_DIR="$REPO_DIR/packages"

HEADLESS=false
[ "$1" == "--headless" ] && HEADLESS=true

log()  { echo -e "\033[1;34m[INFO]\033[0m $1"; }
warn() { echo -e "\033[1;33m[WARN]\033[0m $1"; }
ok()   { echo -e "\033[1;32m[DONE]\033[0m $1"; }

link_dotfile() {
    src="$1"
    dest="$2"
    mkdir -p "$(dirname "$dest")"

    if [ "$(readlink "$dest")" = "$src" ]; then
        ok "Already linked: $dest"
        return
    fi

    if [ -e "$dest" ] || [ -L "$dest" ]; then
        warn "Backing up existing: $dest → $dest.bak"
        mv "$dest" "$dest.bak"
    fi

    ln -sv "$src" "$dest"
}

is_installed() {
    command -v "$1" &>/dev/null
}

install_emacs() {
    if is_installed emacs; then
        ok "Emacs is already installed."
    else
        warn "Emacs not installed. Please install manually."
    fi

    log "Linking Emacs config..."
    link_dotfile "$DOTFILES_DIR/emacs/.emacs" "$HOME/.emacs"
    link_dotfile "$DOTFILES_DIR/emacs/.emacs.custom.el" "$HOME/.emacs.custom.el"
    link_dotfile "$DOTFILES_DIR/emacs/.emacs.local" "$HOME/.emacs.local"
    link_dotfile "$DOTFILES_DIR/emacs/.emacs.rc" "$HOME/.emacs.rc"
    link_dotfile "$DOTFILES_DIR/emacs/.emacs.snippets" "$HOME/.emacs.snippets"
}

install_nvim() {
    if is_installed nvim; then
        ok "Neovim is already installed."
    else
        log "Installing Neovim from source..."
        bash "$PACKAGES_DIR/nvim.sh"
        rm -f nvim-linux-x86_64.tar.gz
    fi

    log "Linking Neovim config..."
    link_dotfile "$DOTFILES_DIR/nvim/.config/nvim" "$HOME/.config/nvim"
}

install_tmux() {
    if is_installed tmux; then
        ok "Tmux is already installed."
    else
        log "Installing Tmux..."
        sudo apt install -y tmux
    fi

    log "Linking Tmux config..."
    link_dotfile "$DOTFILES_DIR/tmux/.tmux.conf" "$HOME/.tmux.conf"
    link_dotfile "$DOTFILES_DIR/tmux/.tmux.conf.local" "$HOME/.tmux.conf.local"
}

install_common_basics() {
    log "Installing Starship and common packages..."

    if is_installed starship; then
        ok "Starship is already installed."
    else
        bash "$SCRIPTS_DIR/starship.sh"
    fi

    REQUIRED_CMDS=(curl git unzip xclip ripgrep wget build-essential)
    NEED_INSTALL=false
    for cmd in "${REQUIRED_CMDS[@]}"; do
        if ! is_installed "$cmd"; then
            NEED_INSTALL=true
            break
        fi
    done

    if $NEED_INSTALL; then
        bash "$SCRIPTS_DIR/common-packages.sh"
    else
        ok "Common packages are already installed."
    fi
}

run_scripts() {
    for script in "$SCRIPTS_DIR"/*.sh; do
        name=$(basename "$script")
        [[ "$name" == "starship.sh" || "$name" == "common-packages.sh" ]] && continue

        if $HEADLESS; then
            log "Running: $name (headless)"
            bash "$script"
        else
            read -rp "Run script '$name'? [y/N]: " answer
            if [[ "$answer" =~ ^[Yy]$ ]]; then
                bash "$script"
            fi
        fi
    done
}

handle_choice() {
    choice="$1"

    case "$choice" in
        1) install_emacs ;;
        2) install_nvim ;;
        3) install_tmux ;;
        4)
            install_common_basics
            install_emacs
            install_nvim
            install_tmux
            ;;
        5)
            install_common_basics
            install_emacs
            install_nvim
            install_tmux
            run_scripts
            ;;
        q|Q) log "Exited by user."; exit 0 ;;
        *) warn "Invalid choice."; exit 1 ;;
    esac

    ok "Setup complete, please restart your shell :)"
}

show_menu() {
    echo "🛠 Dev Environment Setup"
    echo "Choose what to install:"
    echo "1) Emacs only"
    echo "2) Neovim only"
    echo "3) Tmux only"
    echo "4) All configs (with common packages)"
    echo "5) Everything"
    echo "q) Quit"
    echo
    read -rp "👉 Your choice: " choice
    handle_choice "$choice"
}

main() {
    if $HEADLESS; then
        handle_choice 5
    else
        show_menu
    fi
}

main