{ lib, home-manager, impermanence, lanzaboote, config, pkgs, pkgs-unstable, ... }:

{
  imports = [
    ./alacritty.nix
    ./btop.nix
    ./git.nix
    ./gnome.nix
    ./starship.nix
    ./sway.nix
    ./zsh.nix
  ];

  home.username = "crimson";
  home.stateVersion = "23.11";
  programs.home-manager.enable = true;
  home.homeDirectory = "/home/crimson";

  home.file.".config/tmux" = {
    source = ./tmux;
    recursive = true;
  };

  home.file.".config/waybar" = {
    source = ./waybar;
    recursive = true;
  };

  home.file.".config/helix" = {
    source = ./helix;
    recursive = true;
  };

}
