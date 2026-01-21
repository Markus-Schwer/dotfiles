{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    yubikey-manager
    yubioath-flutter
    yubikey-personalization
  ];
}
