{
  description = "lemme smash";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    disko.url = "github:nix-community/disko";
    disko.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    treefmt-nix = {
      url = "github:numtide/treefmt-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, nixos-hardware, home-manager, disko, treefmt-nix, ... }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
          inherit system;
          config = { allowUnfree = true; };
      };
      treefmtEval = treefmt-nix.lib.evalModule pkgs ./treefmt.nix;
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
        };
    in {
      formatter.${system} = treefmtEval.config.build.wrapper;
      checks.${system}.formatter = treefmtEval.config.build.check self;
      nixosConfigurations = {
        thinknix = lib.nixosSystem {
          inherit system;
          modules = [
            defaultModule
            nixos-hardware.nixosModules.lenovo-thinkpad-t495
            ./hardware/thinkpad-t495.nix
            ./modules
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
            defaultModule
            nixos-hardware.nixosModules.lenovo-thinkpad-t495
            ./hardware/qemu.nix
            ./modules
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
            nixos-hardware.nixosModules.lenovo-thinkpad-t495
            ./hardware/desktop.nix
            ./modules
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.markus = import ./home;
            }
          ];
        };
        dankpad = lib.nixosSystem {
          inherit system;
          modules = [
            defaultModule
            disko.nixosModules.disko
            ./hardware/thinkpad-l590.nix
            (import ./disk-config.nix { disk = "/dev/nvme0n1"; })
            ./modules
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
