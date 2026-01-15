# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=10000
HISTFILESIZE=20000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
shopt -s globstar

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability
force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
        # We have color support; assume it's compliant with Ecma-48
        color_prompt=yes
    else
        color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# ls aliases (will be overridden by eza if available)
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Alias definitions.
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# Initialize Starship
if command -v starship >/dev/null 2>&1; then
    eval "$(starship init bash)"
fi

# Eza (ls replacement)
if command -v eza >/dev/null 2>&1; then
    alias ls='eza -a'
    alias ll='eza -alF'
    alias la='eza -A'
    alias l='eza -CF'
    alias lt='eza -T'
fi

# fd (find replacement)
if command -v fdfind >/dev/null 2>&1; then
    alias fd='fdfind'
fi

# Enhanced history
export HISTTIMEFORMAT='%F %T '
export HISTIGNORE='ls:ll:la:cd:pwd:exit:clear:history'

# Node.js via NVM (Lazy Loading for nvm, node, npm, npx, yarn)
export NVM_DIR="$HOME/.nvm"
if [ -s "$NVM_DIR/nvm.sh" ]; then
    _load_nvm() {
        unset -f nvm node npm npx yarn
        [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
        [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
    }
    nvm() { _load_nvm; nvm "$@"; }
    node() { _load_nvm; node "$@"; }
    npm() { _load_nvm; npm "$@"; }
    npx() { _load_nvm; npx "$@"; }
    yarn() { _load_nvm; yarn "$@"; }
fi

# Kubernetes with immediate completion and kubecolor support
if command -v kubectl >/dev/null 2>&1; then
    source <(command kubectl completion bash)
    if command -v kubecolor >/dev/null 2>&1; then
        alias kubectl=kubecolor
        complete -o default -F __start_kubectl kubecolor
    fi
    alias k=kubectl
    complete -o default -F __start_kubectl k
    complete -o default -F __start_kubectl kubectl
fi

# FZF enhanced history search
if command -v fzf >/dev/null 2>&1; then
    __fzf_history() {
        local selected
        selected=$(fc -ln 1 | fzf --tac --no-sort --height 40% --reverse \
            --prompt="History > " --no-preview \
            --bind 'ctrl-y:execute-silent(echo -n {} | xclip -selection clipboard 2>/dev/null || true)')
        if [[ -n "$selected" ]]; then
            READLINE_LINE="$selected"
            READLINE_POINT=${#READLINE_LINE}
        fi
    }
    bind -x '"\C-r": __fzf_history'
fi
