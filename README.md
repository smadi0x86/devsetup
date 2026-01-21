# smadi0x86 dotfiles

Simple dotfiles repository for development tools, editors, and bash configuration.

If you're wondering why I have 2 text editors (`emacs` and `nvim`), I use `nvim` for fast file editing and `emacs` for larger or more structured projects.

## Quick Setup

```bash
git clone https://github.com/smadi0x86/dotfiles.git
cd dotfiles
```

## Setup Instructions

1. **Install system-specific tools:**
   - **Debian**: Follow `amd64/TOOLS.md`
   - **macOS**: Follow `arm64/TOOLS.md`

2. **Setup dotfiles:**

### For Debian (amd64):

```bash
# Git config
ln -sf $(pwd)/amd64/dotfiles/.gitconfig ~/

# Bash configuration  
ln -sf $(pwd)/amd64/dotfiles/bash/.profile ~/
ln -sf $(pwd)/amd64/dotfiles/bash/.bashrc ~/
ln -sf $(pwd)/amd64/dotfiles/bash/.bash_logout ~/

# Shared dotfiles
mkdir -p ~/.config && ln -sf $(pwd)/shared/dotfiles/nvim/.config/nvim ~/.config/

ln -sf $(pwd)/shared/dotfiles/emacs/.emacs ~/
ln -sf $(pwd)/shared/dotfiles/emacs/.emacs.custom.el ~/
ln -sf $(pwd)/shared/dotfiles/emacs/.emacs.local ~/
ln -sf $(pwd)/shared/dotfiles/emacs/.emacs.rc ~/
ln -sf $(pwd)/shared/dotfiles/emacs/.emacs.snippets ~/
ln -sf $(pwd)/shared/dotfiles/tmux/.tmux.conf ~/
ln -sf $(pwd)/shared/dotfiles/tmux/.tmux.conf.local ~/
ln -sf $(pwd)/shared/dotfiles/vim/.vimrc ~/
```

### For macOS (arm64):

```bash
# Git config
ln -sf $(pwd)/arm64/dotfiles/.gitconfig ~/

# Bash configuration
ln -sf $(pwd)/arm64/dotfiles/bash/.profile ~/
ln -sf $(pwd)/arm64/dotfiles/bash/.bashrc ~/
ln -sf $(pwd)/arm64/dotfiles/bash/.bash_logout ~/

# Shared dotfiles  
mkdir -p ~/.config && ln -sf $(pwd)/shared/dotfiles/nvim/.config/nvim ~/.config/

ln -sf $(pwd)/shared/dotfiles/emacs/.emacs ~/
ln -sf $(pwd)/shared/dotfiles/emacs/.emacs.custom.el ~/
ln -sf $(pwd)/shared/dotfiles/emacs/.emacs.local ~/
ln -sf $(pwd)/shared/dotfiles/emacs/.emacs.rc ~/
ln -sf $(pwd)/shared/dotfiles/emacs/.emacs.snippets ~/
ln -sf $(pwd)/shared/dotfiles/tmux/.tmux.conf ~/
ln -sf $(pwd)/shared/dotfiles/tmux/.tmux.conf.local ~/
ln -sf $(pwd)/shared/dotfiles/vim/.vimrc ~/
```

## Git Configuration

Set up git signing with SSH:

```bash
git config --global gpg.format ssh
git config --global user.signingkey ~/.ssh/id_rsa.pub
git config --global commit.gpgsign true
```

Check the `.gitconfig` file and update name, email, and signing key path accordingly.

### Git Aliases Reference

```bash
# Quick essentials
git st              # Status
git aa              # Add all
git cm "msg"        # Commit with message
git pushf           # Push with force-with-lease
git pushu           # Push with set upstream

# Time travel
git undo            # Undo last commit, keep changes
git nuke            # Reset to last commit (destructive)
git back 3          # Go back 3 commits (destructive)
git goto abc123     # Jump to specific commit (destructive)

# Commit combining
git squash 3        # Combine last 3 commits (keeps staged)
git amend           # Fix last commit message/content
git fixup abc123    # Mark commit for squashing

# Stash
git save "msg"      # Stash with message
git pop             # Restore stash
git peek            # Preview stash
git drop            # Delete stash

# History and blame
git lg              # Pretty log graph (10 commits)
git ids             # List commit IDs (20 commits)
git last            # Last commit details
git blame file      # Enhanced blame (ignores whitespace)
git cp abc123       # Cherry-pick commit

# Emergency
git unstage file    # Remove from staging
git abort           # Go back 1 commit (destructive)
```

## Remove Dotfiles

To remove the dotfiles, run:

```bash
rm -f ~/.emacs ~/.emacs.custom.el
rm -f ~/.emacs.local ~/.emacs.rc ~/.emacs.snippets
rm -f ~/.config/nvim
rm -f ~/.tmux.conf ~/.tmux.conf.local
rm -f ~/.gitconfig ~/.vimrc
rm -f ~/.profile ~/.bashrc ~/.bash_logout
```
