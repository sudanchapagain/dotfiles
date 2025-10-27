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

        gc = {
            automatic = true;
            persistent = true;
            dates = "weekly";
            options = "--delete-older-than 7d";
        };
    };
    nixpkgs.config.allowUnfree = true;
}
