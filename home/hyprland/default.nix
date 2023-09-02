{ config, pkgs, ... }:

{
  imports = [
    ./hyprland.nix
    ./waybar
    ./swayidle.nix
    ./swaylock.nix
    ./wofi.nix
  ];
}
