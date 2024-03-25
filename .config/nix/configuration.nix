{ config, pkgs, ... }:
let
  cursor-theme = import ./default.nix { };
  nix-software-center = import
    (builtins.fetchTarball {
      url = "https://github.com/snowfallorg/nix-software-center/archive/refs/tags/0.1.2.tar.gz";
      sha256 = "xiqF1mP8wFubdsAQ1BmfjzCgOD3YZf7EGWl9i69FTls=";
    })
    { };

  nixos-conf-editor-flake = import (pkgs.fetchFromGitHub {
    owner = "snowfallorg";
    repo = "nixos-conf-editor";
    rev = "0.1.2";
    sha256 = "sha256-/ktLbmF1pU3vFHeGooDYswJipNE2YINm0WpF9Wd1gw8=";
  });

in
{
  imports =
    [
      ./hardware-configuration.nix
      #./home.nix
    ];

  # documentation.nixos.enable = false;

  # NEVER CHANGE STATE VERSION.
  system.stateVersion = "23.11";

  nix = {
    nixPath = [ "nixos-config=/home/crimson/.config/nix/configuration.nix" ];

    settings = {
      experimental-features = "nix-command flakes";
      auto-optimise-store = true;
      substituters = [ "https://nix-gaming.cachix.org" ];
      trusted-public-keys = [ "nix-gaming.cachix.org-1:nbjlureqMbRAxR1gJ/f3hxemL9svXaZF/Ees8vCUUs4=" ];
    };

    gc = {
      automatic = true;
      dates = "monthly";
      options = "--delete-older-than 30d";
    };
  };

  nixpkgs = {
    config = {
      allowUnfree = true;
    };
  };


  boot = {
    supportedFilesystems = [ "ntfs" ];
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
  };


  networking = {
    hostName = "crimson";
    networkmanager.enable = true;
    enableIPv6 = false;
    firewall.enable = false;
  };

  time = {
    timeZone = "Asia/Kathmandu";
    hardwareClockInLocalTime = true;
  };
  i18n.defaultLocale = "en_US.UTF-8";

  services = {
    xserver = {
      enable = true;
      xkb.layout = "us";
      xkbVariant = "";

      displayManager.gdm.enable = true;
      desktopManager.gnome.enable = true;

      libinput = {
        enable = true;
        mouse = {
          accelProfile = "adaptive";
          accelSpeed = "-0.5";
          scrollMethod = "twofinger";
        };

        touchpad = {
          accelProfile = "adaptive";
          accelSpeed = "-0.5";
          scrollMethod = "twofinger";
          tapping = true;
          disableWhileTyping = true;
        };
      };
    };

    flatpak.enable = true;
    printing.enable = true;
  };

  security.rtkit.enable = true;

  sound.enable = true;
  hardware.pulseaudio.enable = false;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  users.users.crimson = {
    isNormalUser = true;
    description = "red";
    extraGroups = [ "networkmanager" "wheel" "flatpak" "audio" "video" "root" ];
    packages = with pkgs; [
      nnn
      ripgrep
      jq
      eza
      fzf

      cowsay
      file
      which
      tree
      gnused
      gnutar
      gawk
      zstd
      gnupg
      nix-output-monitor

      glow
      btop
      iotop
      iftop

      strace
      ltrace
      lsof

      sysstat
      lm_sensors
      ethtool
      pciutils
      usbutils
    ];
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    nix-software-center
    nixos-conf-editor-flake.packages.${system}.nixos-conf-editor
    neovim
    sof-firmware
    starship
    wget
    firefox
    networkmanagerapplet
    alacritty
    busybox
    git
    tmux
    neofetch
    btop
    ripgrep
    fzf
    jq
    gcc
    hyprland
    hyprpaper
    waybar
    wayland-protocols
    wayland-utils
    wlroots
    home-manager
    xdg-desktop-portal-gtk
    xdg-desktop-portal-hyprland
    xdg-utils
    xwayland
    pipewire
    stow
    hyprlock
    hypridle
    hyprpaper
    hyprpicker
    refind
    vscodium
    efibootmgr
    cargo
    rustc
    nodejs
    bat
    celluloid
    dunst
    wofi
    flatpak
    fontconfig
    freetype
    gnumake
    luarocks

    gnomeExtensions.blur-my-shell
    #    gnomeExtensions.
  ];

  programs = {
    neovim = {
      enable = true;
      defaultEditor = true;
    };

    hyprland = {
      enable = true;
    };
  };

  xdg.portal = {
    enable = true;
    wlr.enable = true;
    # extraPortals = [
    #  pkgs.xdg-desktop-portal-gtk
    #];
  };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };


  fonts = {
    enableGhostscriptFonts = true;
    packages = with pkgs;[
      corefonts
      noto-fonts
      noto-fonts-cjk
      noto-fonts-emoji
      font-awesome
      liberation_ttf
      inter
      (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
    ];

    fontconfig = {
      enable = true;
      defaultFonts = {
        serif = [ "Noto Serif" ];
        monospace = [ "JetBrainsMono" ];
        sansSerif = [ "Inter" "Noto Sans" ];
        emoji = [ "Noto Color Emoji" ];
      };
    };
  };


  services = {
    #    openssh.enable = true;
    dbus.enable = true;
  };

  environment = {
    gnome = {
      excludePackages = (with pkgs; [ gnome-tour ]) ++ (with pkgs.gnome; [
        epiphany
        totem
      ]);
    };
  };



}
