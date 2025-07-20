#!/bin/bash

set -e

log()  { echo -e "\033[1;34m[INFO]\033[0m $1"; }
ok()   { echo -e "\033[1;32m[DONE]\033[0m $1"; }
warn() { echo -e "\033[1;33m[WARN]\033[0m $1"; }

backup_and_remove() {
    target="$1"
    if [ -L "$target" ]; then
        log "Removing symlink: $target"
        rm -v "$target"
    elif [ -e "$target" ]; then
        warn "Backing up existing file: $target → $target.bak"
        mv "$target" "$target.bak"
    fi
}

log "Unlinking dotfiles..."

# Emacs
backup_and_remove "$HOME/.emacs"
backup_and_remove "$HOME/.emacs.custom.el"
backup_and_remove "$HOME/.emacs.local"
backup_and_remove "$HOME/.emacs.rc"
backup_and_remove "$HOME/.emacs.snippets"
backup_and_remove "$HOME/.emacs.d"

# Neovim
backup_and_remove "$HOME/.config/nvim"

# Tmux
backup_and_remove "$HOME/.tmux.conf"
backup_and_remove "$HOME/.tmux.conf.local"

ok "All dotfiles unlinked!"