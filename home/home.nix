{ lib, home-manager, impermanence, lanzaboote, config, pkgs, pkgs-unstable, ... }:

{
  imports = [
    ./starship.nix
  ];

  home.username = "crimson";
  home.stateVersion = "23.11";
  programs.home-manager.enable = true;
  home.homeDirectory = "/home/crimson";
}
