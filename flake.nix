{
  description = "System configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:NixOS/nixpkgs/nixos-23.11";
    nixpkgs-wayland.url = "github:nix-community/nixpkgs-wayland";

    home-manager.url = "github:nix-community/home-manager/release-23.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    impermanence.url = "github:nix-community/impermanence";
    lanzaboote = {
      url = "github:nix-community/lanzaboote/v0.3.0";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixvim.url = "github:nix-community/nixvim";
    nixvim.inputs.nixpkgs.follows = "nixpkgs";

  };

  outputs = inputs@{ nixpkgs, home-manager, impermanence, lanzaboote, ... }: {
    nixosConfigurations = {
      crimson = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./system/system.nix
          impermanence.nixosModules.impermanence
          # home manager as module of nixos
          home-manager.nixosModules.home-manager{
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.crimson = import ./home/home.nix;
          }
        ];
      };
    };
  };

}
