{ config, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    emacs

    # GNOME DEVELOPMENT
    glib
    gtk4
    libadwaita
    meson

    alacritty
    neovim
    firefox

    # TEXT
    vscodium
    neovim

    # MEDIA
    celluloid
    ffmpeg
    yt-dlp

    emote

    # DESKTOP
    home-manager
    starship
    wofi
    tmux

    # UTILITIES
    bat
    btop
    eza
    fzf
    neofetch
    ripgrep

    # DEV
    go
    nixpkgs-fmt
    nixpkgs-lint
    nodejs
    odin
    ols
    sysprof

    # SYSTEM COMPONENTS
    busybox
    flatpak
    fontconfig
    freetype
    git
    gnumake
    efibootmgr
    pipewire
    refind
    sof-firmware
    wayland-protocols
    wayland-utils
    wget
    wlroots
    xdg-desktop-portal-gtk
    xdg-desktop-portal
    xdg-utils
    xwayland

    # GNOME RELATED
    gnome-extension-manager
    gnome.gnome-shell-extensions
    gnomeExtensions.blur-my-shell
    gnomeExtensions.pop-shell
    gnomeExtensions.color-picker
    gnome.gnome-tweaks
    gnome.dconf-editor
  ];

  programs = {
    sway = {
      enable = true;
      extraPackages = with pkgs; [
        brightnessctl
        playerctl
        pulseaudio
        swaybg
        swaylock
        swayidle
        ulauncher
        waybar
        xwayland
      ];
    };
    neovim = {
      enable = true;
      defaultEditor = true;
    };
  };

  environment = {
    gnome = {
      excludePackages =
        (with pkgs; [
          gnome-tour
          gnome-connections
          gedit
        ])
        ++
        (with pkgs.gnome; [
          gnome-characters
          gnome-contacts
          gnome-maps
          gnome-music
          gnome-weather
          cheese
          geary
          epiphany
          #evince
          totem
        ]);
    };
  };

}
