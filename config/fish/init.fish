set -g fish_greeting
if status is-interactive
    # SETTINGS
    set -g fish_color_autosuggestion "#d8a755"
    # ALIAS
    alias pretty "git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"
    alias ls "eza -g --icons --hyperlink"
    alias ll "eza -lg --icons --hyperlink"
    alias l "eza -lga --icons --hyperlink"
    alias c clear
    alias x exit
    alias e "nautilus ."
    alias hx helix
    # ENV
    set -U fish_user_paths $HOME/.cargo/bin $HOME/.local/bin $fish_user_paths
    # COMMANDS
    starship init fish | source
    fastfetch -c examples/8.jsonc
end
