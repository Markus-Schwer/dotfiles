{ pkgs, ... }:

{
  services.protonmail-bridge = {
    enable = true;
    path = with pkgs; [ gnome-keyring ];
  };
}
