# ~/.bashrc: executed by bash(1) for non-login shells.
# Modified for Apple Silicon.

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# History
HISTCONTROL=ignoreboth
shopt -s histappend
HISTSIZE=10000
HISTFILESIZE=20000
export HISTTIMEFORMAT='%F %T '
export HISTIGNORE='ls:ll:la:cd:pwd:exit:clear:history'

# Shell options
shopt -s checkwinsize
shopt -s globstar

# Grep colors
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

# ls aliases (will be overridden by exa if available)
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Bash completion
[ -f /usr/local/etc/bash_completion ] && . /usr/local/etc/bash_completion

# Locale
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

# -----------------------------------------------------

# Initialize Starship
if command -v starship >/dev/null 2>&1; then
    eval "$(starship init bash)"
fi

# Exa (ls replacement)
if command -v exa >/dev/null 2>&1; then
    alias ls='exa -a'
    alias ll='exa -alF'
    alias la='exa -A'
    alias l='exa -CF'
    alias lt='exa -T'
fi


# Development Languages (Homebrew paths set in .profile)
PATH="$HOME/go/bin:$PATH"

# Node.js via Homebrew

# Kubernetes
if command -v kubectl >/dev/null 2>&1; then
    kubectl() {
        if ! complete -p kubectl >/dev/null 2>&1; then
            source <(command kubectl completion bash)
            if command -v kubecolor >/dev/null 2>&1; then
                alias kubectl=kubecolor
                complete -o default -F __start_kubectl kubecolor
            fi
            complete -o default -F __start_kubectl kubectl
            complete -o default -F __start_kubectl k
        fi
        command kubectl "$@"
    }
    alias k=kubectl
fi

# FZF enhanced history search
if command -v fzf >/dev/null 2>&1; then
    __fzf_history() {
        local selected
        selected=$(fc -ln 1 | fzf --tac --no-sort --height 40% --reverse \
            --prompt="History > " --no-preview \
            --bind 'ctrl-y:execute-silent(echo -n {} | pbcopy 2>/dev/null || true)')
        
        if [[ -n "$selected" ]]; then
            READLINE_LINE="$selected"
            READLINE_POINT=${#READLINE_LINE}
        fi
    }
    bind -x '"\C-r": __fzf_history'
fi
