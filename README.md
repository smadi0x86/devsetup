# smadi0x86 dotfiles

Simple dotfiles repository for development tools, editors, and bash configuration.

If you're wondering why I have 2 text editors (`emacs` and `nvim`), I use `nvim` for fast file editing and `emacs` for larger or more structured projects.

## Quick Setup

```bash
git clone https://github.com/smadi0x86/devsetup.git
cd devsetup
```

## Install Dotfiles

Create symlinks:

```bash
ln -sf $(pwd)/dotfiles/emacs/.emacs ~/
ln -sf $(pwd)/dotfiles/emacs/.emacs.custom.el ~/
ln -sf $(pwd)/dotfiles/emacs/.emacs.local ~/
ln -sf $(pwd)/dotfiles/emacs/.emacs.rc ~/
ln -sf $(pwd)/dotfiles/emacs/.emacs.snippets ~/

mkdir -p ~/.config && ln -sf $(pwd)/dotfiles/nvim/.config/nvim ~/.config/

ln -sf $(pwd)/dotfiles/tmux/.tmux.conf ~/
ln -sf $(pwd)/dotfiles/tmux/.tmux.conf.local ~/
ln -sf $(pwd)/dotfiles/.gitconfig ~/
ln -sf $(pwd)/dotfiles/vim/.vimrc ~/
ln -sf $(pwd)/dotfiles/bash/.profile ~/
ln -sf $(pwd)/dotfiles/bash/.bashrc ~/
ln -sf $(pwd)/dotfiles/bash/.bash_logout ~/
```

## Tools

See `TOOLS.md` for categorized installation instructions for all development tools.

## Git Configuration

Set up git signing with SSH:

```bash
git config --global gpg.format ssh
git config --global user.signingkey ~/.ssh/id_rsa.pub
git config --global commit.gpgsign true
```

Check the `.gitconfig` file and update name, email, and signing key path accordingly.

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
