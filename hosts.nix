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
  {
    name = "dankpad";
    system = "x86_64-linux";
    nixosModules = [
      disko.nixosModules.disko
      ./hardware/thinkpad-l590.nix
      (import ./disko-config.nix { disk = "/dev/nvme0n1"; })
      {
        markus.network = {
          hostname = "nixpad";
          hostid = "ea12bde6";
        };
        markus.k3s.enable = true;
        services.k3s.extraFlags = toString [
          "--disable=traefik"
        ];
        networking.extraHosts = ''
          192.168.178.147 keycloak.fcp.local
          192.168.178.147 fnt-application.fcp.local
          192.168.178.147 fcp-master.fcp.local
          192.168.178.147 grafana.fcp.local
          192.168.178.147 command.fcp.local
          192.168.178.147 minio.fcp.local
          192.168.178.147 minio-console.fcp.local
          192.168.178.147 minio-backup.fcp.local
          192.168.178.147 camunda.fcp.local
          192.168.178.147 serviceplanet.fcp.local
          192.168.178.147 analytics.fcp.local
          192.168.178.147 adminer.fcp.local
          192.168.178.147 keycloak.smoke.local
          192.168.178.147 fnt-application.smoke.local
          192.168.178.147 fnt-application.fcp-clone.local
          192.168.178.147 minio.fcp-clone.local
          192.168.178.147 analytics.fcp-clone.local
          192.168.178.147 fnt-monitoring.fcp.local
        '';
      }
    ];
  }
]
