{ config, pkgs, ... }:
{
  wayland.windowManager.sway =
    let
      glyphs-picker = import ../../pkgs/glyphs-picker.nix { inherit pkgs; };
      wallpaper = builtins.fetchurl {
        url = "https://my.hidrive.com/api/sharelink/download?id=lECFE2kr";
        sha256 = "1sxwsvq8d1qnimnahdyjpzb94rzycnksr4m7j1khdm3ikxz9w33a";
      };
      cfg = config.wayland.windowManager.sway.config;
      modeShutdown = "(h) hibernate (l) lock (e) logout (r) reboot (u) suspend (s) shutdown";
    in
    {
      enable = true;
      systemd.enable = true;
      config = {
        modifier = "Mod4";
        terminal = "alacritty";
        menu = "${pkgs.wofi}/bin/wofi --show=drun";
        modes."${modeShutdown}" = {
          "h" = "systemctl hibernate";
          "l" = "${pkgs.swaylock}/bin/swaylock";
          "e" = "loginctl terminate-user $USER";
          "r" = "systemctl reboot";
          "u" = "systemctl suspend";
          "s" = "systemctl shutdown";
          Escape = "mode default";
          Return = "mode default";
        };
        keybindings = {
          # Shutdown mode
          "${cfg.modifier}+Shift+e" = "mode ${modeShutdown}";

          # Multimedia Keys
          "XF86AudioMute" = "exec ${pkgs.pulseaudio}/bin/pactl set-sink-mute @DEFAULT_SINK@ toggle";
          "XF86AudioMicMute" = "exec ${pkgs.pulseaudio}/bin/pactl set-source-mute @DEFAULT_SOURCE@ toggle";
          "--locked XF86MonBrightnessDown" = "exec ${pkgs.brightnessctl}/bin/brightnessctl set -5%";
          "--locked XF86MonBrightnessUp" = "exec ${pkgs.brightnessctl}/bin/brightnessctl set +5%";
          "XF86AudioRaiseVolume" = "exec ${pkgs.pulseaudio}/bin/pactl set-sink-volume @DEFAULT_SINK@ +5%";
          "XF86AudioLowerVolume" = "exec ${pkgs.pulseaudio}/bin/pactl set-sink-volume @DEFAULT_SINK@ -5%";
        };
        bars = [ ]; # managed as systemd user unit
        /* fonts = { */
        /*   names = [ "JetBrainsMono Nerd Font" "monospace" ]; */
        /*   style = "Regular"; */
        /*   size = 10.0; */
        /* }; */
      };
      /* extraConfig = '' */
      /*   # Cursor */
      /*   seat seat0 xcursor_theme Adwaita */
      /* ''; */
    };
}
