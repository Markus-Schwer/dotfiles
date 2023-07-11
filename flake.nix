{
  description = "lemme smash";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-23.05";
    nixpkgs-unstable.url = "nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager/release-23.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
  };

  outputs = { nixpkgs, nixpkgs-unstable, nixos-hardware, home-manager, ... }:
    let
      system = "x84_64-linux";
      pkgs = import nixpkgs {
          inherit system;
          config = { allowUnfree = true; };
      };
      lib = nixpkgs.lib;
    in {
      formatter.x86_64-linux = nixpkgs.legacyPackages.x86_64-linux.nixpkgs-fmt;
      nixosConfigurations = {
        thinknix = lib.nixosSystem {
          inherit system;
          modules = [
            nixos-hardware.nixosModules.lenovo-thinkpad-t495
            ./modules
            ./hardware/thinkpad-t495.nix
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.markus = import ./home;
            }
            ({ config, pkgs, ... }: 
              let
                overlay-unstable = final: prev: {
                  unstable = nixpkgs-unstable.legacyPackages.x86_64-linux;
                };
              in
	          {
                nixpkgs.overlays = [ overlay-unstable ]; 
                environment.systemPackages = with pkgs; [
	              unstable.hydroxide
	            ];
	          }
	        )
          ];
        };
        qemu = lib.nixosSystem {
          inherit system;
          modules = [
            ./modules
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
