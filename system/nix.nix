{ config, pkgs, ... }:

{
    nix = {
        settings = {
            experimental-features = [
                "nix-command"
                "flakes"
            ];
            auto-optimise-store = true;
        };

        gc.automatic = true;
        gc.persistent = true;
        gc.dates = "weekly";
        gc.options = "--delete-older-than 7d";
    };
    nixpkgs.config.allowUnfree = true;
}
