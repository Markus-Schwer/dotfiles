{ config, lib, ... }:
with lib;
let
  cfg = config.markus.network;
in
{
  options.markus.network = {
    hostname = mkOption {
      type = types.str;
    };
    hostid = mkOption {
      type = types.str;
      description = "output of head -c 8 /etc/machine-id";
    };
  };
  config = {
    networking = {
      hostName = cfg.hostname;
      hostId = cfg.hostid;
      networkmanager.enable = true;
    };
  };
}
