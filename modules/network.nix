{ config, lib, ... }:
with lib;
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
      hostName = config.markus.network.hostname;
      hostId = config.markus.network.hostid;
      networkmanager = {
        enable = true;
        # wifi.backend = "iwd"; # unstable
      };
    };
  };
}
