# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
        . "$HOME/.bashrc"
    fi
fi

# set PATH so it includes user's private bin if it exists
PATH="$HOME/bin:$HOME/.local/bin:/usr/local/go/bin:$HOME/go/bin:/usr/share/dotnet:$PATH"

# Add system admin tools to PATH for regular users
case ":$PATH:" in
    *:/usr/sbin:*) ;;
    *) PATH="/usr/local/sbin:/usr/sbin:/sbin:$PATH" ;;
esac

export PATH

# Set Locale
export LANG=en_US.UTF-8

# Rust/Cargo environment
[ -f "$HOME/.cargo/env" ] && . "$HOME/.cargo/env"
