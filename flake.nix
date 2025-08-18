{
  description = "lemme smash";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-25.05";
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
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    treefmt-nix = {
      url = "github:numtide/treefmt-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    flake-utils.url = "github:numtide/flake-utils";
    nix-darwin = {
      url = "github:nix-darwin/nix-darwin/nix-darwin-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs @ { self, nixpkgs, nixpkgs-unstable, nixos-hardware, home-manager, disko, treefmt-nix, agenix, flake-utils, nix-darwin, ... }:
    {
      nixosConfigurations = builtins.listToAttrs (
        builtins.map
          (host:
            let
              system = host.system;
              customNeovimOverlay = final: prev: {
                neovim = self.packages.${system}.neovim;
              };

              pkgs = import nixpkgs {
                inherit system;
                config = {
                  allowUnfree = true;
                  permittedInsecurePackages = [
                    "beekeeper-studio-5.1.5"
                    "yubikey-manager-qt-1.2.5"
                  ];
                };

                overlays = [ customNeovimOverlay ];
              };
              pkgs-unstable = import nixpkgs-unstable {
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
            in
            {
              name = host.name;
              value = lib.nixosSystem {
                inherit system pkgs;
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
    } // (
      let
        system = "aarch64-darwin";
        customNeovimOverlay = final: prev: {
          neovim = self.packages.${system}.neovim;
        };

        pkgs = import nixpkgs {
          inherit system;
          config = { allowUnfree = true; };
          overlays = [ customNeovimOverlay ];
        };
      in
      {
        homeConfigurations."schwerm" = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          modules = [
            ({
              home = {
                username = "schwerm";
                homeDirectory = "/Users/schwerm";
                stateVersion = "24.11";

                # set nvim as the default editor
                sessionVariables = { EDITOR = "nvim"; };
              };

              programs.home-manager.enable = true;
              programs.zsh.enable = true;
              programs.tmux.shell = "/bin/zsh";

              fonts.fontconfig.enable = true;

              home.packages = with pkgs; [
                vim
                neovim
                postgresql_17
                llama-cpp
              ];

              imports = [
                ./home/tmux.nix
              ];
            })
          ];
        };
      }
    ) // flake-utils.lib.eachDefaultSystem (system:
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

        treefmtEval = treefmt-nix.lib.evalModule pkgs ./treefmt.nix;

        neovim = (import ./pkgs/neovim { inherit pkgs pkgs-unstable lib; });
      in
      {
        formatter = treefmtEval.config.build.wrapper;
        checks.formatter = treefmtEval.config.build.check self;

        packages.home-manager = home-manager.defaultPackage.${system};
        packages.neovim = neovim;
        apps.neovim = {
          type = "app";
          program = "${neovim}/bin/nvim";
        };
      });
}
