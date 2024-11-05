#!/bin/zsh

mkdir -p ~/.local/bin
mkdir -p ~/.local/share/applications
mkdir -p ~/.local/share/icons/hicolor/{16x16,32x32,48x48,128x128,256x256,512x512}/apps

cp zig-out/bin/ghostty ~/.local/bin/
cp dist/linux/app.desktop ~/.local/share/applications/

icon_sizes=(16 32 128 256 512)

for size in "${icon_sizes[@]}"; do
    if [[ -f images/icons/icon_${size}x${size}.png ]]; then
        cp images/icons/icon_${size}x${size}.png ~/.local/share/icons/hicolor/${size}x${size}/apps/ghostty.png
    else
        echo "Warning: Icon file images/icons/icon_${size}x${size}.png not found."
    fi
done

update-desktop-database ~/.local/share/applications
gtk-update-icon-cache

echo "Installation completed successfully."
