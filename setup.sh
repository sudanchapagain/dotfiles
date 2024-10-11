#!/bin/bash

SYSTEM_PACKAGE_MANAGER="apt"
FLATPAK_REPO="flathub"
SNAP_PACKAGES=("helix" "btop" "yt-dlp")
FLATPAK_PACKAGES=("com.rafaelmardojai.SharePreview" "com.vscodium.codium" "io.github.seadve.Kooha" "org.mozilla.firefox")
SYSTEM_PACKAGES=("git" "stow" "busybox" "ffmpeg" "cargo" "fzf" "podman" "ripgrep")
CARGO_PACKAGES=("tokei" "eza" "binsider" "xplr")

check_command() {
    command -v "$1" >/dev/null 2>&1
}

update_and_install_system_packages() {
    sudo "$SYSTEM_PACKAGE_MANAGER" update && sudo "$SYSTEM_PACKAGE_MANAGER" upgrade -y
    for pkg in "${SYSTEM_PACKAGES[@]}"; do
        if dpkg -s "$pkg" >/dev/null 2>&1; then
            sudo "$SYSTEM_PACKAGE_MANAGER" install --only-upgrade -y "$pkg"
        else
            sudo "$SYSTEM_PACKAGE_MANAGER" install -y "$pkg"
        fi
    done
}

install_flatpak_packages() {
    flatpak remote-add --if-not-exists "$FLATPAK_REPO" https://flathub.org/repo/flathub.flatpakrepo
    for pkg in "${FLATPAK_PACKAGES[@]}"; do
        if ! flatpak list --app | grep -q "$pkg"; then
            flatpak install -y "$pkg"
        fi
    done
}

install_snap_packages() {
    for pkg in "${SNAP_PACKAGES[@]}"; do
        if ! snap list | grep -q "$pkg"; then
            sudo snap install "$pkg"
        fi
    done
}

install_cargo_packages() {
    if check_command "cargo"; then
        for pkg in "${CARGO_PACKAGES[@]}"; do
            if ! cargo install --list | grep -q "$pkg"; then
                cargo install "$pkg"
            fi
        done
    fi
}

handle_git_commit() {
    read -p "Do you want to commit changes to Git? (y/n) " commit_choice
    if [[ "$commit_choice" == "y" ]]; then
        read -p "Enter commit message: " commit_message
        git add .
        git commit -m "$commit_message"
    fi
}

initial_setup() {
    mkdir -p ~/.config/alacritty ~/.config/helix ~/.config/starship ~/.config/tmux
}

install_new_packages() {
    for pkg in "${SYSTEM_PACKAGES[@]}"; do
        if ! dpkg -s "$pkg" >/dev/null 2>&1; then
            sudo "$SYSTEM_PACKAGE_MANAGER" install -y "$pkg"
        fi
    done

    for pkg in "${FLATPAK_PACKAGES[@]}"; do
        if ! flatpak list --app | grep -q "$pkg"; then
            flatpak install -y "$pkg"
        fi
    done

    for pkg in "${SNAP_PACKAGES[@]}"; do
        if ! snap list | grep -q "$pkg"; then
            sudo snap install "$pkg"
        fi
    done

    if check_command "cargo"; then
        for pkg in "${CARGO_PACKAGES[@]}"; do
            if ! cargo install --list | grep -q "$pkg"; then
                cargo install "$pkg"
            fi
        done
    fi
}

print_help() {
    echo "+--------------------------------------------------------------+"
    echo "| Usage: ./setup.sh <command>                                  |"
    echo "| Commands:                                                    |"
    echo "|   full-setup        run all commands including initial setup |"
    echo "|   new               install only newly added packages        |"
    echo "|   help              show this help message                   |"
    echo "+--------------------------------------------------------------+"
}

case "$1" in
    full-setup)
        update_and_install_system_packages
        install_flatpak_packages
        install_snap_packages
        install_cargo_packages
        initial_setup
        run_stow
        handle_git_commit
        ;;
    new)
        install_new_packages
        ;;
    dot)
        symlink_dotfiles
        ;;
    help)
        print_help
        ;;
    *)
        echo ""
        echo "Unknown command: $1"
        print_help
        ;;
esac
