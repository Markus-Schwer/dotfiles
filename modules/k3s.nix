{ config, pkgs, lib, ...}:
with lib;
{
  options.markus.k3s = {
    enable = mkOption {
      type = types.bool;
      default = false;
    };
  };
  config = {
    services.k3s.enable = config.markus.k3s.enable;
    services.k3s.role = "server";
    environment.systemPackages = with pkgs; [ k3s ];
  };
}
