#!/bin/zsh

# doas apk add distrobox
# distrobox-create --name zig-container --image alpine:latest
# distrobox-enter zig-container
# sudo vi /etc/apk/repositories
#   Append the following lines
#   https://dl-cdn.alpinelinux.org/alpine/edge/main
#   https://dl-cdn.alpinelinux.org/alpine/edge/community
# sudo apk update
# sudo apk add zig libadwaita-dev gtk4.0-dev

wget https://github.com/ghostty-org/ghostty/releases/download/tip/ghostty-source.tar.gz
tar -xzf ghostty-source.tar.gz
cd ghostty-source

zig build -Doptimize=ReleaseFast