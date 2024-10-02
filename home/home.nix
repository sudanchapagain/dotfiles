{ lib, home-manager, impermanence, lanzaboote, config, pkgs, pkgs-unstable, ... }:

{
  imports = [
    ./alacritty.nix
    ./btop.nix
    ./git.nix
    ./eos.nix
    ./starship.nix
    ./packages.nix
    ./zsh.nix
  ];

  home.username = "crimson";
  home.stateVersion = "24.05";
  programs.home-manager.enable = true;
  home.homeDirectory = "/home/crimson";

  home.file.".config/tmux" = {
    source = ./tmux;
    recursive = true;
  };

  home.file.".config/helix" = {
    source = ./helix;
    recursive = true;
  };

}
