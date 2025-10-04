{
  description = "System configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";

    home-manager.url = "github:nix-community/home-manager/master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    # impermanence.url = "github:nix-community/impermanence";
    lanzaboote = {
      url = "github:nix-community/lanzaboote/v0.4.2";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    
    agenix.url = "github:ryantm/agenix";
    agenix.inputs.nixpkgs.follows = "nixpkgs";
    agenix.inputs.darwin.follows = "";
  };

  outputs = inputs@{ nixpkgs, home-manager, #impermanence,
  lanzaboote, agenix, ... }: {
    nixosConfigurations = {
      crimson = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./config/config.nix
          agenix.nixosModules.default
          # impermanence.nixosModules.impermanence
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

