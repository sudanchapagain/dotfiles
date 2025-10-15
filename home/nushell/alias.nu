alias pretty = git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit

alias lo = ls
alias ls = eza -g --icons --hyperlink
alias l = eza -lga --icons --hyperlink
alias ll = eza -lg --icons --hyperlink
alias lt = eza --tree --level=2 --long --icons --git
alias ltt = eza --tree --long --icons --git

alias c = clear
alias x = exit
alias e = nautilus .

def gl [] {
    git log --pretty=format:"%h»¦«%s»¦«%aN»¦«%aE»¦«%aD" -n 10
    | lines
    | split column "»¦«" sha1 subject name email date
    | upsert date {|d| $d.date | into datetime}
}
