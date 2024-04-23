{ lib, config, pkgs, ... }:
{
  system.stateVersion = "23.11";

  nix = {
    settings = {
      experimental-features = "nix-command flakes";
      auto-optimise-store = true;
      substituters = [
          "https://nix-gaming.cachix.org"
          "https://nixos-homepage.cachix.org"
      ];
      trusted-public-keys = [
          "nix-gaming.cachix.org-1:nbjlureqMbRAxR1gJ/f3hxemL9svXaZF/Ees8vCUUs4="
          "nixos-homepage.cachix.org-1:NHKBt7NjLcWfgkX4OR72q7LVldKJe/JOsfIWFDAn/tE="
      ];
    };

    gc.automatic = true;
    gc.persistent = true;
    gc.dates = "weekly";
    gc.options = "--delete-older-than 7d";
  };
  nixpkgs.config.allowUnfree = true;

}
