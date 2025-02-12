{ lib, config, pkgs, ... }:
{
  imports = [
    ./boot.nix
    ./fonts.nix
    ./general.nix
    ./hardware-configuration.nix
    ./hardware.nix
    ./input.nix
    ./network.nix
    ./nix.nix
    ./packages.nix
    ./persistence.nix
    ./services.nix
    ./sound.nix
    ./systemd.nix
    ./user.nix
  ];
}
