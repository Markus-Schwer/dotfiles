{ pkgs, ... }:

{
  # disable rpfilter so that wireguard works
  networking.firewall.checkReversePath = false;
  networking.firewall = {
    enable = true;
    allowedTCPPortRanges = [
      { from = 1714; to = 1764; } # KDE Connect
    ];
    allowedUDPPortRanges = [
      { from = 1714; to = 1764; } # KDE Connect
    ];
    allowedTCPPorts = [ 7236 7250 ]; # gnome-network-displays
    allowedUDPPorts = [ 7236 5353 ]; # gnome-network-displays
  };
}
