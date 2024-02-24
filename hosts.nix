{ nixos-hardware, disko }:
[
  {
    name = "thinknix";
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
  {
    name = "dankpad";
    nixosModules = [
      disko.nixosModules.disko
      ./hardware/thinkpad-l590.nix
      (import ./disko-config.nix { disk = "/dev/nvme0n1"; })
      {
        markus.network = {
          hostname = "nixpad";
          hostid = "ea12bde6";
        };
      }
    ];
  }
]
