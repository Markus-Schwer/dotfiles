{ config, ... }:
let
  prefer-dark-theme = if (config.markus.theme == "light") then "0" else "1";
in {
  environment.etc = {
    "xdg/gtk-2.0/gtkrc".text = "gtk-application-prefer-dark-theme=${prefer-dark-theme}";
    "xdg/gtk-3.0/settings.ini".text = ''
      [Settings]
      gtk-application-prefer-dark-theme=${prefer-dark-theme}
    '';
    "xdg/gtk-4.0/settings.ini".text = ''
      [Settings]
      gtk-application-prefer-dark-theme=${prefer-dark-theme}
    '';
  };
}
