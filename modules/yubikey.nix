{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    yubikey-manager
    yubikey-manager-qt
    yubikey-personalization
    yubikey-personalization-gui
  ];
}
