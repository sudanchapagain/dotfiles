{
    description = "system configuration";

    inputs.nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";

    outputs =
        { nixpkgs, ... }:
        {
            nixosConfigurations = {
                crimson = nixpkgs.lib.nixosSystem {
                    modules = [
                        ./system/system.nix
                        { nixpkgs.hostPlatform = "x86_64-linux"; }
                    ];
                };
            };
        };
}
