{ nixos-hardware, disko }:
[
  {
    name = "nixwork";
    system = "x86_64-linux";
    nixosModules = [
      disko.nixosModules.disko
      nixos-hardware.nixosModules.framework-13-7040-amd
      ./hardware/framework-13-inch-7040-amd.nix
      (import ./disko-config.nix { disk = "/dev/nvme0n1"; })
      {
        markus.network = {
          hostname = "nixwork";
          hostid = "19dba1ec";
        };
      }
    ];
  }
  {
    name = "thinknix";
    system = "x86_64-linux";
    nixosModules = [
      disko.nixosModules.disko
      nixos-hardware.nixosModules.lenovo-thinkpad-t495
      ./hardware/thinkpad-t495.nix
      (import ./disko-config.nix { disk = "/dev/nvme0n1"; })
      {
        markus.network = {
          hostname = "thinknix";
          hostid = "a167e424";
        };
      }
    ];
  }
  {
    name = "desktop";
    system = "x86_64-linux";
    nixosModules = [
      ./hardware/desktop.nix
      {
        markus.network = {
          hostname = "nixpad";
          hostid = "a167e424";
        };
      }
    ];
  }
]
