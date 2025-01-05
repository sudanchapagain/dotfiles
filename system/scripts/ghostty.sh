#!/bin/sh

# doas apk add distrobox
# distrobox-create --name zig-container --image alpine:latest
# distrobox-enter zig-container
# doas vi /etc/apk/repositories
#   Append the following lines
#   https://dl-cdn.alpinelinux.org/alpine/edge/main
#   https://dl-cdn.alpinelinux.org/alpine/edge/community
# doas apk update
# doas apk upgrade
# doas apk add zig libadwaita-dev gtk4.0-dev

git clone https://github.com/ghostty-org/ghostty .

zig build -Doptimize=ReleaseFast

#mkdir -p ~/.local/bin
#mkdir -p ~/.local/share/applications
#mkdir -p ~/.local/share/icons/hicolor/16x16/apps
#mkdir -p ~/.local/share/icons/hicolor/32x32/apps
#mkdir -p ~/.local/share/icons/hicolor/48x48/apps
#mkdir -p ~/.local/share/icons/hicolor/128x128/apps
#mkdir -p ~/.local/share/icons/hicolor/256x256/apps
#mkdir -p ~/.local/share/icons/hicolor/512x512/apps

cp zig-out/bin/ghostty ~/.local/bin/

#cp zig-out/share/applications/com.mitchellh.ghostty.desktop ~/.local/share/applications/

#cp "images/icons/icon_16x16.png" ~/.local/share/icons/hicolor/16x16/apps/ghostty.png
#cp "images/icons/icon_32x32.png" ~/.local/share/icons/hicolor/32x32/apps/ghostty.png
#cp "images/icons/icon_128x128.png" ~/.local/share/icons/hicolor/128x128/apps/ghostty.png
#cp "images/icons/icon_256x256.png" ~/.local/share/icons/hicolor/256x256/apps/ghostty.png
#cp "images/icons/icon_512x512.png" ~/.local/share/icons/hicolor/512x512/apps/ghostty.png

#update-desktop-database ~/.local/share/applications
