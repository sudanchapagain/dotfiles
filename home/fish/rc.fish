alias pretty "git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"
alias ls "eza -g --icons --hyperlink"
alias ll "eza -lg --icons --hyperlink"
alias l "eza -lga --icons --hyperlink"
alias c clear
alias x exit
alias e "nautilus ."

if type -q fzf
    fzf --fish | source
end

if type -q starship
    starship init fish | source
end

set -U fish_user_paths $HOME/.cargo/bin $HOME/.local/bin $fish_user_paths
