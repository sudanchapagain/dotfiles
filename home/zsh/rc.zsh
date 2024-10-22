# Set zinit dir
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

# Get Zinit, if not found
if [ ! -d "$ZINIT_HOME" ]; then
   mkdir -p "$(dirname $ZINIT_HOME)"
   git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

# Source zinit
source "${ZINIT_HOME}/zinit.zsh"

# Add in zsh plugins
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light Aloxaf/fzf-tab

# Zsh options and completion
autoload -Uz compinit && compinit

zinit cdreplay -q

# History settings
HISTSIZE=5000
SAVEHIST=5000
HISTDUP=erase
HISTFILE=~/.zsh_history

setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

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
