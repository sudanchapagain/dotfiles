{ lib, home-manager, impermanence, lanzaboote, config, pkgs, ... }:

{
  imports = [
    ./alacritty.nix
    ./bash.nix
    ./btop.nix
    #./firefox.nix
    ./git.nix
    ./gnome.nix
    ./hyprland.nix
    #./nvim
    #./nixvim.nix
    ./starship.nix
  ];

  home.username = "crimson";
  home.stateVersion = "23.11";
  programs.home-manager.enable = true;
  home.homeDirectory = "/home/crimson";

  home.file.".config/starship.toml".source = starship/starship.toml;

  home.file.".config/tmux" = {
    source = ./tmux;
    recursive = true;
  };

  home.file.".config/nvim" = {
    source = ./nvim;
    recursive = true;
  };

  home.file.".config/wofi" = {
    source = ./wofi;
    recursive = true;
  };
}
