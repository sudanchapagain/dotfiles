{ config, pkgs, ... }:
let
  cursor-theme = import ./default.nix { };
  #  nix-software-center = import
  #    (builtins.fetchTarball {
  #      url = "https://github.com/snowfallorg/nix-software-center/archive/refs/tags/0.1.2.tar.gz";
  #      sha256 = "xiqF1mP8wFubdsAQ1BmfjzCgOD3YZf7EGWl9i69FTls=";
  #    })
  #    { };
  #
  #  nixos-conf-editor-flake = import (pkgs.fetchFromGitHub {
  #    owner = "snowfallorg";
  #    repo = "nixos-conf-editor";
  #    rev = "0.1.2";
  #    sha256 = "sha256-/ktLbmF1pU3vFHeGooDYswJipNE2YINm0WpF9Wd1gw8=";
  #  });

in
{
  imports =
    [
      ./hardware-configuration.nix
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

  security.polkit.enable = true;
  systemd = {
    user.services.polkit-gnome-authentication-agent-1 = {
      description = "polkit-gnome-authentication-agent-1";
      wantedBy = [ "graphical-session.target" ];
      wants = [ "graphical-session.target" ];
      after = [ "graphical-session.target" ];
      serviceConfig = {
        Type = "simple";
        ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
        Restart = "on-failure";
        RestartSec = 1;
        TimeoutStopSec = 10;
      };
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
  hardware = {
    pulseaudio.enable = false;
    bluetooth.enable = true;
  };
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
    packages = with pkgs; [ ];
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    alacritty
    bat
    btop
    busybox
    cargo
    celluloid
    dunst
    efibootmgr
    eza
    fd
    firefox
    flatpak
    fontconfig
    freetype
    fzf
    gcc
    git
    gitkraken
    glow
    gnomeExtensions.blur-my-shell
    gnomeExtensions.pop-shell
    gnumake
    home-manager

    #hypridle
    hyprland
    #hyprlock
    hyprpaper
    hyprpicker

    jq
    luarocks
    neofetch
    neovim
    networkmanagerapplet
    nix-output-monitor
    #nix-software-center
    #nixos-conf-editor-flake.packages.${system}.nixos-conf-editor
    nodejs
    pamixer
    pipewire
    polkit
    polkit_gnome
    refind
    ripgrep
    rustc
    sof-firmware
    starship
    stow
    tree
    tmux
    vscodium
    waybar
    wayland-protocols
    wayland-utils
    wget
    which
    wlroots
    wofi
    xdg-desktop-portal-gtk
    xdg-desktop-portal-hyprland
    xdg-utils
    xwayland
    zsh
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
