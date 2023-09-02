{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "markus";
  home.homeDirectory = "/home/markus";

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "23.05";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  home.packages = with pkgs; [
    killall
    firefox
    thunderbird
    gimp
    spice-vdagent
    neofetch
    alacritty # gpu accelerated terminal
    mako # notification system
    bemenu # launch menu
    openvpn
    element-desktop #-wayland
    thunderbird
    terraform
    nmap
    signal-desktop
    freecad
    drawio
    cargo
    rustc
    spotify
    inkscape
    fluxcd
    kubeseal
    chromium
    platformio
    usbutils
  ];

  xdg.enable = true;

  programs.bash.enable = true;

  imports = [
    ./hyprland
    ./kubectl.nix
    ./go.nix
    ./nvim
    ./kdeconnect.nix
  ];
}
