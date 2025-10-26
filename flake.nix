{
    description = "System configuration";

    inputs = {
        nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
        home-manager.url = "github:nix-community/home-manager/master";
        home-manager.inputs.nixpkgs.follows = "nixpkgs";
        lanzaboote.url = "github:nix-community/lanzaboote/v0.4.2";
        lanzaboote.inputs.nixpkgs.follows = "nixpkgs";
        ignis.url = "github:ignis-sh/ignis";
        ignis.inputs.nixpkgs.follows = "nixpkgs";
    };

    outputs =
        inputs@{
            self,
            nixpkgs,
            home-manager,
            lanzaboote,
            ...
        }:
        {
            nixosConfigurations = {
                crimson = nixpkgs.lib.nixosSystem {
                    system = "x86_64-linux";
                    modules = [
                        ./system/config.nix
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
