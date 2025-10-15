{
    description = "System configuration";

    inputs = {
        nixpkgs = {
            url = "github:nixos/nixpkgs?ref=nixos-unstable";
        };

        home-manager.url = "github:nix-community/home-manager/master";
        home-manager.inputs.nixpkgs.follows = "nixpkgs";

        lanzaboote = {
            url = "github:nix-community/lanzaboote/v0.4.2";
            inputs.nixpkgs.follows = "nixpkgs";
        };

        agenix = {
            url = "github:ryantm/agenix";
            inputs.nixpkgs.follows = "nixpkgs";
        };

        quickshell = {
            url = "github:outfoxxed/quickshell";
            inputs.nixpkgs.follows = "nixpkgs";
        };
        noctalia = {
            url = "github:noctalia-dev/noctalia-shell";
            inputs.nixpkgs.follows = "nixpkgs";
            inputs.quickshell.follows = "quickshell";
        };
    };

    outputs =
        inputs@{
            self,
            nixpkgs,
            home-manager,
            lanzaboote,
            agenix,
            ...
        }:
        {
            nixosConfigurations = {
                crimson = nixpkgs.lib.nixosSystem {
                    system = "x86_64-linux";
                    modules = [
                        ./system/config.nix
                        agenix.nixosModules.default
                        home-manager.nixosModules.home-manager
                        {
                            home-manager.useGlobalPkgs = true;
                            home-manager.useUserPackages = true;
                            home-manager.users.crimson = import ./home/home.nix;
                        }
                    ];
                };
            };
        };
}
