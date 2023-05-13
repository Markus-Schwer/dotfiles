{
  description = "lemme smash";

  inputs = {
    hixpkgs.url = "nixpkgs/nixos-22.11";
    home-manager.url = "github:nix-community/home-manager/release-22.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
  };

  outputs = { nixpkgs, nixos-hardware, home-manager, ... }:
    let
      system = "x84_64-linux";
      pkgs = import nixpkgs {
          inherit system;
          #config = { allowUnfree = true; };
      };
      lib = nixpkgs.lib;
    in {
      formatter.x86_64-linux = nixpkgs.legacyPackages.x86_64-linux.nixpkgs-fmt;
      nixosConfigurations = {
        markus-nixos = lib.nixosSystem {
          inherit system;
          modules = [
            nixos-hardware.nixosModules.lenovo-thinkpad-t495
            ./modules
            #./hardware/thinkpad-t495.nix
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.markus = import ./home;
            }
          ];
        };
        qemu = lib.nixosSystem {
          inherit system;
          modules = [
            ./modules
            ./configuration.nix
            ./hardware/qemu.nix
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.markus = import ./home;
            }
          ];
        };
      };
    };
}
