function fish_greeting
    fastfetch -c examples/8.jsonc
    set -x GOPATH $HOME/go
    set -x PATH $PATH /usr/local/go/bin $GOPATH/bin
end
