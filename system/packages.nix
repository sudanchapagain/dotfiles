{ config, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    emacs
    gcc
    clang-tools
    cloc

    # GNOME DEVELOPMENT
    glib
    glib.dev
    gtk4
    libadwaita
    meson

    alacritty
    neovim
    firefox

    # TEXT
    vscodium
    texliveMinimal
    neovim

    # MEDIA
    celluloid
    ffmpeg
    yt-dlp

    # PRODUCTIVITY
    anytype
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
    fd
    fzf
    glow
    jq
    neofetch
    ripgrep

    # DEV
    erlang
    gitkraken
    gleam
    go
    kotlin
    lua
    luarocks
    nodejs
    odin
    ols
    sysprof
    toolbox
    vala
    yt-dlp

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
        wofi
        swaybg
        swaylock
        swayidle
        xwayland
        mako
        grim
        slurp
        wl-clipboard
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
