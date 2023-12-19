{
  description = "lemme smash";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    nixpkgs-unstable.url = "nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
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
      defaultModule =
        { lib, ... }:
        {
          nix.registry = {
            home-manager.flake = home-manager;
            nixpkgs.flake = nixpkgs;
            #sops-nix.flake = sops-nix;
          };
          nix.nixPath = lib.mkForce [
            "nixpkgs=${nixpkgs}"
            #"sops-nix=${sops-nix}"
            "home-manager=${home-manager}"
            "nixos-hardware=${nixos-hardware}"
          ];
          nix.settings.experimental-features = [
            "nix-command"
            "flakes"
          ];
          #time.timeZone = "UTC";
        };
    in {
      formatter.x86_64-linux = nixpkgs.legacyPackages.x86_64-linux.nixpkgs-fmt;
      nixosConfigurations = {
        thinknix = lib.nixosSystem {
          inherit system;
          modules = [
            defaultModule
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
            defaultModule
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
        desktop = lib.nixosSystem {
          inherit system;
          modules = [
            defaultModule
            ./modules
            ./hardware/desktop.nix
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
      };
    };
}
