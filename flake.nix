{
    description = "System configuration";

    inputs = {
        nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
        impermanence.url = "github:nix-community/impermanence";

        lanzaboote = {
            url = "github:nix-community/lanzaboote/v0.4.2";
            inputs.nixpkgs.follows = "nixpkgs";
        };
    };

    outputs =
        inputs@{
            nixpkgs,
            lanzaboote,
            impermanence,
            ...
        }:
        {
            nixosConfigurations = {
                crimson = nixpkgs.lib.nixosSystem {
                    modules = [
                        ./system/system.nix
                        { nixpkgs.hostPlatform = "x86_64-linux";}
                    ];
                };
            };
        };
}
