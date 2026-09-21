{
  description = "lemme smash";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-26.05";
    nixpkgs-unstable.url = "nixpkgs/nixos-unstable";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    agenix = {
      url = "github:ryantm/agenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    agenix-rekey = {
      url = "github:oddlama/agenix-rekey";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    treefmt-nix = {
      url = "github:numtide/treefmt-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    flake-utils.url = "github:numtide/flake-utils";
    nixgl.url = "github:nix-community/nixGL";
    nix-versions = {
      url = "github:vic/nix-versions";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.treefmt-nix.follows = "treefmt-nix";
    };
  };

  outputs =
    inputs@{
      self,
      nixpkgs,
      nixpkgs-unstable,
      nixos-hardware,
      home-manager,
      disko,
      treefmt-nix,
      agenix,
      agenix-rekey,
      flake-utils,
      nixgl,
      nix-versions,
      ...
    }:
    let
      mapHost = host: rec {
        system = host.system;
        customNeovimOverlay = final: prev: {
          neovim = self.packages.${system}.neovim;
        };

        pkgs = import nixpkgs {
          inherit system;
          config = {
            allowUnfree = true;
            permittedInsecurePackages = [
              "electron-39.8.10"
              "beekeeper-studio-5.3.4"
              "yubikey-manager-qt-1.2.5"
            ];
          };

          overlays = [ customNeovimOverlay nixgl.overlay ];
        };
        pkgs-unstable = import nixpkgs-unstable {
          inherit system;
          config = {
            allowUnfree = true;
          };
        };
        lib = nixpkgs.lib;
        defaultModule =
          { lib, ... }:
          {
            nix.package = pkgs.nix;
            nix.registry = {
              home-manager.flake = home-manager;
              nixpkgs.flake = nixpkgs;
              agenix.flake = agenix;
              agenix-rekey.flake = agenix-rekey;
            };
            nix.nixPath = lib.mkForce [
              "nixpkgs=${nixpkgs}"
              "agenix=${agenix}"
              "agenix-rekey=${agenix-rekey}"
              "home-manager=${home-manager}"
              "nixos-hardware=${nixos-hardware}"
            ];
            nix.settings = {
              experimental-features = [
                "nix-command"
                "flakes"
              ];
              substituters = [
                #"https://cache-pub.aalen.space" # local pull-through cache of cache.nixos.org
                "https://cache.nixos.org"
                #"https://cache.aalen.space"
              ];
              trusted-public-keys = [
                "cache.aalen.space:Q74dc8HOhsLT3v4tj8fz6NhyuzIpCnK6OyA0XNjW6r8"
              ];
              trusted-users = [
                "@wheel"
              ];
            };
          };

        nixosConfiguration = lib.nixosSystem {
          inherit system pkgs;
          modules = [
            defaultModule
            ./modules
            agenix.nixosModules.default
            home-manager.nixosModules.home-manager
            (
              { config, ... }:
              {
                home-manager.useGlobalPkgs = true;
                home-manager.useUserPackages = true;
                home-manager.users.markus = import ./home;
                home-manager.extraSpecialArgs = {
                  inherit inputs pkgs-unstable nixgl nix-versions;
                  markus = config.markus;
                };
              }
            )
          ]
          ++ host.nixosModules;
          specialArgs = { inherit inputs self pkgs-unstable; };
        };

        homeConfiguration = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          modules = [defaultModule] ++ host.homeManagerModules;
          extraSpecialArgs = {
            inherit inputs self pkgs-unstable nixgl nix-versions;
            markus = {
              theme = "dark";
              backup.enable = false;
            };
          };
        };
      };
    in
    {
      nixosConfigurations = builtins.listToAttrs (
        builtins.map (host: {
          name = host.name;
          value = (mapHost host).nixosConfiguration;
        }) (import ./hosts.nix { inherit nixos-hardware disko; })
      );

      homeConfigurations = builtins.listToAttrs (
        builtins.map (host: {
          name = host.name;
          value = (mapHost host).homeConfiguration;
        }) (import ./hosts.nix { inherit nixos-hardware disko; })
      );
    }
    // flake-utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = import nixpkgs {
          inherit system;
          config = {
            allowUnfree = true;
          };
        };
        pkgs-unstable = import nixpkgs-unstable {
          inherit system;
          config = {
            allowUnfree = true;
          };
        };
        lib = pkgs.lib;

        treefmtEval = treefmt-nix.lib.evalModule pkgs ./treefmt.nix;

        neovim = (
          import ./pkgs/neovim {
            inherit
              nixpkgs
              system
              pkgs-unstable
              lib
              ;
          }
        );
      in
      {
        formatter = treefmtEval.config.build.wrapper;
        checks.formatter = treefmtEval.config.build.check self;

        packages.home-manager = home-manager.packages.${system}.default;
        packages.neovim = neovim;
        apps.neovim = {
          type = "app";
          program = "${neovim}/bin/nvim";
        };
      }
    );
}
