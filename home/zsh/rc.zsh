# Zsh options and completion
autoload -Uz compinit && compinit

# Autosuggestions and Syntax Highlighting
if command -v zsh-autosuggestions > /dev/null; then
  source $(dirname $(realpath $(which zsh-autosuggestions)))/zsh-autosuggestions.zsh
fi

if command -v zsh-syntax-highlighting > /dev/null; then
  source $(dirname $(realpath $(which zsh-syntax-highlighting)))/zsh-syntax-highlighting.zsh
fi

# History settings
HISTSIZE=5000
SAVEHIST=5000
HISTFILE=~/.zsh_history
setopt SHARE_HISTORY HIST_IGNORE_DUPS HIST_IGNORE_ALL_DUPS HIST_IGNORE_SPACE

zshaddhistory() {
  local hist_ignore_patterns=("rm *" "ls" "l" "ll" "exit")
  for pattern in $hist_ignore_patterns; do
    [[ $1 == $pattern ]] && return 1
  done
  return 0
}

# Shell aliases
alias pretty="git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"
alias ls="eza -g --icons --hyperlink"
alias ll="eza -lg --icons --hyperlink"
alias l="eza -lga --icons --hyperlink"
alias c="clear"
alias sysbuild="sudo nixos-rebuild switch --flake ~/dotfiles/"

# Vi mode and history search keybindings
bindkey -v
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward

# Fzf integration
if command -v fzf > /dev/null; then
  eval "$(fzf --zsh)"
fi

# Zsh completion settings
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'

# Auto-start tmux
if command -v tmux > /dev/null 2>&1; then
  [ -z "$TMUX" ] && exec tmux
fi

# Starship prompt
if command -v starship > /dev/null; then
  eval "$(starship init zsh)"
fi

export PATH="$HOME/.cargo/bin:$PATH"
