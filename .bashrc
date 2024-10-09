# ~/.bashrc: executed by bash(1) for non-login interactive shells.

# If not running interactively, exit early.
case $- in
    *i*) ;;   # Interactive shell
      *) return;;  # Non-interactive shell
esac

HISTSIZE=5000
HISTFILE=~/.bash_history
shopt -s histignoredups         # Ignore duplicate commands in history
shopt -s histappend             # Append to history file, don't overwrite
shopt -s histignorespace        # Ignore commands starting with a space
export HISTIGNORE="rm *:ls:l:ll:exit"  # Ignore specific commands from history

# Terminal size check after each command
shopt -s checkwinsize

# Lesspipe (optimized for non-interactive shells)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# Set chroot identifier if applicable
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# Enable color prompt if terminal supports it
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
        color_prompt=yes
    else
        color_prompt=
    fi
fi

# Set prompt with or without color based on terminal support
if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# Set terminal title for xterm and similar terminals
case "$TERM" in
    xterm*|rxvt*)
        PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
        ;;
esac

# Enable dircolors and color support for ls, grep, etc.
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# Custom Aliases
alias pretty="git log --graph --pretty=format:'%h - %d %s (%ar) <%an>' --abbrev-commit"
alias ls="eza -g --icons --hyperlink"
alias ll="eza -lg --icons --hyperlink"
alias l="eza -lga --icons --hyperlink"
alias c="clear"
alias sysbuild="sudo nixos-rebuild switch --flake ~/dotfiles/"

# Key Bindings (History search)
bind '"\C-p": history-search-backward'
bind '"\C-n": history-search-forward'

# Enable fzf (fuzzy finder) if installed
if command -v fzf > /dev/null 2>&1; then
    eval "$(fzf --bash)"
fi

# Launch tmux if installed and not already inside a tmux session
if command -v tmux > /dev/null 2>&1; then
    [ -z "$TMUX" ] && exec tmux
fi

# Initialize Starship prompt (cross-shell prompt)
eval "$(starship init bash)"

# Load Bash Aliases (if ~/.bash_aliases exists)
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# Enable Bash completion (if available)
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi