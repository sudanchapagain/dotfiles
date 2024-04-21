export HISTCONTROL=ignoreboth:erasedups
eval "$(starship init bash)"
[[ $TERM != "screen" ]] && exec tmux -u
