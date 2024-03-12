{
  description = "lemme smash";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    disko.url = "github:nix-community/disko";
    disko.inputs.nixpkgs.follows = "nixpkgs";
    agenix.url = "github:ryantm/agenix";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    treefmt-nix = {
      url = "github:numtide/treefmt-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs @ { self, nixpkgs, nixos-hardware, home-manager, disko, treefmt-nix, agenix, ... }:
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
            agenix.flake = agenix;
          };
          nix.nixPath = lib.mkForce [
            "nixpkgs=${nixpkgs}"
            "agenix=${agenix}"
            "home-manager=${home-manager}"
            "nixos-hardware=${nixos-hardware}"
          ];
          nix.settings.experimental-features = [
            "nix-command"
            "flakes"
          ];
        };
    in
    {
      formatter.${system} = treefmtEval.config.build.wrapper;
      checks.${system}.formatter = treefmtEval.config.build.check self;
      packages.${system}.disko-config = import ./disko-config.nix;
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
                {
                  home-manager.useGlobalPkgs = true;
                  home-manager.useUserPackages = true;
                  home-manager.users.markus = import ./home;
                  home-manager.extraSpecialArgs = inputs;
                }
              ] ++ host.nixosModules;
              specialArgs = { inherit inputs self; };
            };
          })
          (import ./hosts.nix { inherit nixos-hardware disko; }));
    };
}
