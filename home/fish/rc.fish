alias pretty "git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"
alias ls "eza -g --icons --hyperlink"
alias ll "eza -lg --icons --hyperlink"
alias l "eza -lga --icons --hyperlink"
alias c clear
alias x exit
alias sudo doas
alias e "nautilus ."

if type -q fzf
    fzf --fish | source
end

if type -q starship
    starship init fish | source
end

set wkdev_sdk_directory /home/crimson/Projects/webkit-container-sdk
set -x WKDEV_SDK $wkdev_sdk_directory
set -x PATH "$WKDEV_SDK/scripts:$WKDEV_SDK/scripts/host-only:(python3 -m site --user-base)/bin:$PATH"

set -U fish_user_paths $HOME/.cargo/bin $HOME/.local/bin $fish_user_paths
