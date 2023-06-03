{ config, pkgs, ... }:

{
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
      modifier = "Mod4";
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
