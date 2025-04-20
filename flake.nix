{
  description = "lemme smash";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-24.11";
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
    home-manager = {
      url = "github:nix-community/home-manager/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    treefmt-nix = {
      url = "github:numtide/treefmt-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = inputs @ { self, nixpkgs, nixpkgs-unstable, nixos-hardware, home-manager, disko, treefmt-nix, agenix, flake-utils, ... }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        config = { allowUnfree = true; };
      };
      pkgs-unstable = import nixpkgs-unstable {
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
            agenix.flake = agenix;
          };
          nix.nixPath = lib.mkForce [
            "nixpkgs=${nixpkgs}"
            "agenix=${agenix}"
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
              "https://cache.aalen.space"
            ];
            trusted-public-keys = [
              "cache.aalen.space:Q74dc8HOhsLT3v4tj8fz6NhyuzIpCnK6OyA0XNjW6r8"
            ];
            trusted-users = [
              "@wheel"
            ];
          };
        };
    in
    {
      formatter.${system} = treefmtEval.config.build.wrapper;
      checks.${system}.formatter = treefmtEval.config.build.check self;
      nixosConfigurations = builtins.listToAttrs (
        builtins.map
          (host: {
            name = host.name;
            value = lib.nixosSystem {
              inherit system;
              modules = [
                defaultModule
                ./modules
                agenix.nixosModules.default
                home-manager.nixosModules.home-manager
                ({ config, ... }: {
                  home-manager.useGlobalPkgs = true;
                  home-manager.useUserPackages = true;
                  home-manager.users.markus = import ./home;
                  home-manager.extraSpecialArgs = {
                    inherit inputs pkgs-unstable;
                    theme = config.markus.theme;
                  };
                })
              ] ++ host.nixosModules;
              specialArgs = { inherit inputs self pkgs-unstable; };
            };
          })
          (import ./hosts.nix { inherit nixos-hardware disko; }));
    } // flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs {
          inherit system;
          config = { allowUnfree = true; };
        };
        pkgs-unstable = import nixpkgs-unstable {
          inherit system;
          config = { allowUnfree = true; };
        };
        lib = pkgs.lib;

        neovim = (import ./pkgs/neovim { inherit pkgs pkgs-unstable lib; });
      in
      {
        packages.neovim = neovim;
        apps.neovim = {
          type = "app";
          program = "${neovim}/bin/nvim";
        };
      });
}
