{ config, pkgs, networking, ... }:

{
  home.packages = with pkgs; [
    spotify
  ];

  # spotify connect
  networking.firewall.allowedTCPPorts = [ 57621 ];
}
