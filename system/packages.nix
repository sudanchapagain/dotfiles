{ config, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    # APP
    planify
    foliate

    # DEVELOPMENT
    alacritty
    helix
    tmux
    git
    firefox
    vscodium

    glib
    gtk4
    libadwaita

    meson
    gnumake
    sysprof
    gnome.dconf-editor

    nixpkgs-fmt
    nixpkgs-lint
    nodejs
    odin
    ols

    # MEDIA
    ffmpeg
    yt-dlp

    # UTILS & SYSTEM COMPONENTS
    btop
    eza
    fzf
    wget
    ripgrep
    neofetch
    starship
    home-manager

    busybox
    flatpak
    fontconfig
    freetype
    efibootmgr
    refind

    pipewire
    sof-firmware

    wayland-protocols
    wayland-utils
    wlroots
    xdg-desktop-portal-gtk
    xdg-desktop-portal
    xdg-utils
    xwayland
  ];

  programs = {
    sway = {
      enable = true;
      package = pkgs.swayfx;
      wrapperFeatures.gtk = true;
      extraPackages = with pkgs; [
        brightnessctl
        playerctl
        pulseaudio
        swaybg
        swaylock
        swayidle
        ulauncher
        waybar
        wofi
        xwayland
      ];
    };
  };

  environment = {
    pantheon = {
      excludePackages = 
        (with pkgs; [
          plank
        ])
        ++
        (with pkgs.pantheon; [
          elementary-terminal
          elementary-code
          elementary-tasks
          elementary-mail
          elementary-calendar
          epiphany
        ]);
    };
  };
}
