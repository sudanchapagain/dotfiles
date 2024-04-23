{ config, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    # IMPORTANT
    alacritty
    neovim
    firefox
    tmux

    # GENERAL GUI
    celluloid
    emote
    gitkraken
    home-manager
    hyprland
    vscodium
    wofi

    # GENERAL CLI
    bat
    btop
    eza
    fd
    ffmpeg
    fzf
    glow
    jq
    neofetch
    ripgrep
    starship

    # LANGUAGES
    go
    lua
    luarocks
    nixd
    nixpkgs-fmt
    nodejs
    odin

    # CORE
    busybox
    flatpak
    fontconfig
    freetype
    git
    gnumake
    efibootmgr
    pipewire
    polkit
    polkit_gnome
    refind
    sof-firmware
    wayland-protocols
    wayland-utils
    wget
    wlroots
    xdg-desktop-portal-gtk
    xdg-desktop-portal
    xdg-desktop-portal-hyprland
    xdg-utils
    xwayland

    # GNOME RELATED
    gnome-extension-manager
    gnome.gnome-shell-extensions
    gnomeExtensions.blur-my-shell
    gnomeExtensions.pop-shell
    gnomeExtensions.color-picker
    gnome.gnome-tweaks
  ];

  programs = {
    hyprland.enable = true;
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
  };

  environment = {
    gnome = {
      excludePackages =
        (with pkgs; [
          gnome-tour
          gnome-connections
        ])
        ++
        (with pkgs.gnome; [
          gnome-characters
          gnome-contacts
          gnome-maps
          gnome-music
          gnome-weather
          cheese
          gedit
          geary
          epiphany
          evince
          totem
        ]);
    };
  };

}
