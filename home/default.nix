{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "markus";
  home.homeDirectory = "/home/markus";

  home.packages = with pkgs; [
    killall
    firefox
    thunderbird
    spice-vdagent
    neofetch
    alacritty # gpu accelerated terminal
    mako # notification system
    bemenu # launch menu
  ];

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "22.11";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  programs.bash.enable = true;

  # sway
  #programs.swaylock.enable = true;
  #programs.swayidle.enable = true;

  home.pointerCursor = {
    gtk.enable = true;
    package = pkgs.gnome.adwaita-icon-theme;
    name = "Adwaita";
    size = 38;
    x11 = {
      enable = true;
      defaultCursor = "Adwaita";
    };
  };

  wayland.windowManager.sway = {
    enable = true;
    wrapperFeatures.gtk = true;
    config = rec {
      modifier = "Mod1";
      terminal = "alacritty"; 
      menu = "bemenu-run";
      startup = [
        # Launch Firefox on start
        #{command = "firefox";}
        {command = "alacritty";}
      ];
      #seat = {
      #  "*" = {
      #    xcursor_theme = "Adwaita 38";
      #  };
      #};
    };
    extraConfig = "seat seat0 xcursor_theme Adwaita 38\n";
  };
}
