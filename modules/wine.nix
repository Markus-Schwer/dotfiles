{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    wineWowPackages.waylandFull
    winetricks
  ];
}
