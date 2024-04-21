{
  description = "System configuration";

  inputs = {
    # NIX RELATED
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:NixOS/nixpkgs/nixos-23.11";
    nixpkgs-wayland.url = "github:nix-community/nixpkgs-wayland";
    impermanence.url = "github:nix-community/impermanence";
    home-manager.url = "github:nix-community/home-manager/release-23.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    # EXTRA
    lanzaboote = {
      url = "github:nix-community/lanzaboote/v0.3.0";
      inputs.nixpkgs.follows = "nixpkgs";
    };
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
