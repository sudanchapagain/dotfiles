set -g fish_greeting

if status is-interactive
    # SETTINGS
    set -g fish_color_autosuggestion "#d8a755"

    # ALIAS
    alias pretty "git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"

    alias sdk='bash -c "source $HOME/.sdkman/bin/sdkman-init.sh && sdk $argv"'

    alias lo ls # ls original
    alias ls "eza -g --icons --hyperlink"
    alias l "eza -lga --icons --hyperlink"
    alias ll "eza -lg --icons --hyperlink"
    alias lt "eza --tree --level=2 --long --icons --git"
    alias ltt "exa --tree --long --icons --git"

    alias c clear
    alias x exit
    alias e "nautilus ."
    alias rm "rm -i"
    alias hx helix

    alias tdl "td list"
    alias tda "td add"
    alias tdd "td delete"
    alias tdu "td update"

    # ENV
    set -U fish_user_paths $HOME/.cargo/bin $HOME/.local/bin $fish_user_paths $HOME/.local/share/JetBrains/Toolbox/scripts

    # COMMANDS
    starship init fish | source
    fastfetch -c examples/8.jsonc
end
