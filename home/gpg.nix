{ pkgs, ... }:

{
  programs.gpg.enable = true;
  services.gpg-agent.enable = true;

  home.packages = with pkgs; [
    pinentry
  ];
}
