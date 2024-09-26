{ config, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    gnome.dconf-editor
    planify
    tuba
    video-trimmer
    flare-signal
    gnome.polari
    fractal
    foliate
    apostrophe
    contrast
    citations
    endeavour
    helix
  
    # GNOME DEVELOPMENT
    glib
    gtk4
    libadwaita
    meson

    alacritty
    firefox
    vscodium

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
    btop
    eza
    fzf
    neofetch
    ripgrep

    # DEV
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
  ];

  programs = {
    sway = {
      enable = true;
      package = pkgs.swayfx;
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
  };
}
