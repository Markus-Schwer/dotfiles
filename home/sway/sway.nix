{ config, pkgs, ... }:
{
  wayland.windowManager.sway =
    let
      glyphs-picker = import ../../pkgs/glyphs-picker.nix { inherit pkgs; };
      wallpaper = ./wallpapers/mars.jpg;
      cfg = config.wayland.windowManager.sway.config;
      modeShutdown = "(h) hibernate (l) lock (e) logout (r) reboot (u) suspend (s) shutdown";
      modeScreenshot = "󰄄  (r) region (s) screen";
    in
    {
      enable = true;
      package = pkgs.swayfx;
      extraConfig = ''
        for_window [app_id="floating_shell"] floating enable, border pixel 1, sticky enable
        for_window [title="dmenu"] floating enable, border pixel 1, sticky enable
        for_window [title="nwg-displays"] floating enable, border pixel 1, sticky enable
        corner_radius 4
        blur enable
      '';
      config = {
        modifier = "Mod4";
        terminal = "alacritty";
        menu = "${pkgs.wofi}/bin/wofi --show=drun";
        output = {
          "*" = {
            bg = "${wallpaper} fill";
          };
          "eDP-1" = {
            pos = "1920 0";
          };
          "HDMI-A-1" = {
            pos = "0 0";
          };
        };
        gaps = {
          inner = 6;
          smartBorders = "off";
        };
        fonts.names = [ "JetBrainsMono Nerd Font" "Roboto Mono" "sans-serif" ];
        window = {
          /* titlebar = false; */
          border = 1;
        };
        floating = {
          /* titlebar = false; */
          border = 1;
        };
        colors = {
          focused = {
            border = "#8C3D2B";
            background = "#59281D";
            text = "#cccccc";
            indicator = "#cccccc";
            childBorder = "#8C3D2B";
          };
          focusedInactive = {
            border = "#8C6056";
            background = "#593E38";
            text = "#cccccc";
            indicator = "#cccccc";
            childBorder = "#8C6056";
          };
          unfocused = {
            border = "#444444";
            background = "#222222";
            text = "#cccccc";
            indicator = "#cccccc";
            childBorder = "#444444";
          };
          urgent = {
            border = "#8C3D2B";
            background = "#F26A4B";
            text = "#cccccc";
            indicator = "#cccccc";
            childBorder = "#8C3D2B";
          };
        };
        bars = [ ]; # managed as systemd user unit
        input = {
          "type:touchpad" = {
            tap = "enabled";
            natural_scroll = "enabled";
          };
          "type:keyboard" = {
            xkb_layout = "us,de";
          };
        };
        keybindings = {
          # Basics
          "${cfg.modifier}+Return" = "exec ${cfg.terminal}";
          "${cfg.modifier}+Shift+q" = "kill";
          "${cfg.modifier}+d" = "exec ${cfg.menu}";
          "${cfg.modifier}+Control+r" = "reload";

          # Focus
          "${cfg.modifier}+${cfg.left}" = "focus left";
          "${cfg.modifier}+${cfg.down}" = "focus down";
          "${cfg.modifier}+${cfg.up}" = "focus up";
          "${cfg.modifier}+${cfg.right}" = "focus right";

          "${cfg.modifier}+Left" = "focus left";
          "${cfg.modifier}+Down" = "focus down";
          "${cfg.modifier}+Up" = "focus up";
          "${cfg.modifier}+Right" = "focus right";

          "${cfg.modifier}+tab" = "workspace back_and_forth";

          # Moving
          "${cfg.modifier}+Shift+${cfg.left}" = "move left";
          "${cfg.modifier}+Shift+${cfg.down}" = "move down";
          "${cfg.modifier}+Shift+${cfg.up}" = "move up";
          "${cfg.modifier}+Shift+${cfg.right}" = "move right";

          "${cfg.modifier}+Shift+Left" = "move left";
          "${cfg.modifier}+Shift+Down" = "move down";
          "${cfg.modifier}+Shift+Up" = "move up";
          "${cfg.modifier}+Shift+Right" = "move right";

          # Workspaces
          "${cfg.modifier}+1" = "workspace number 1";
          "${cfg.modifier}+2" = "workspace number 2";
          "${cfg.modifier}+3" = "workspace number 3";
          "${cfg.modifier}+4" = "workspace number 4";
          "${cfg.modifier}+5" = "workspace number 5";
          "${cfg.modifier}+6" = "workspace number 6";
          "${cfg.modifier}+7" = "workspace number 7";
          "${cfg.modifier}+8" = "workspace number 8";
          "${cfg.modifier}+9" = "workspace number 9";
          "${cfg.modifier}+0" = "workspace number 10";

          "${cfg.modifier}+Shift+1" = "move container to workspace number 1";
          "${cfg.modifier}+Shift+2" = "move container to workspace number 2";
          "${cfg.modifier}+Shift+3" = "move container to workspace number 3";
          "${cfg.modifier}+Shift+4" = "move container to workspace number 4";
          "${cfg.modifier}+Shift+5" = "move container to workspace number 5";
          "${cfg.modifier}+Shift+6" = "move container to workspace number 6";
          "${cfg.modifier}+Shift+7" = "move container to workspace number 7";
          "${cfg.modifier}+Shift+8" = "move container to workspace number 8";
          "${cfg.modifier}+Shift+9" = "move container to workspace number 9";
          "${cfg.modifier}+Shift+0" = "move container to workspace number 10";

          # Moving workspaces between outputs
          "${cfg.modifier}+Control+${cfg.left}" = "move workspace to output left";
          "${cfg.modifier}+Control+${cfg.down}" = "move workspace to output down";
          "${cfg.modifier}+Control+${cfg.up}" = "move workspace to output up";
          "${cfg.modifier}+Control+${cfg.right}" = "move workspace to output right";

          "${cfg.modifier}+Control+Left" = "move workspace to output left";
          "${cfg.modifier}+Control+Down" = "move workspace to output down";
          "${cfg.modifier}+Control+Up" = "move workspace to output up";
          "${cfg.modifier}+Control+Right" = "move workspace to output right";

          # Splits
          "${cfg.modifier}+b" = "splith";
          "${cfg.modifier}+v" = "splitv";

          # Layouts
          "${cfg.modifier}+s" = "layout stacking";
          "${cfg.modifier}+w" = "layout tabbed";
          "${cfg.modifier}+e" = "layout toggle split";
          "${cfg.modifier}+f" = "fullscreen toggle";

          "${cfg.modifier}+a" = "focus parent";

          "${cfg.modifier}+Control+space" = "floating toggle";

          # Resize mode
          "${cfg.modifier}+r" = "mode resize";

          # Shutdown mode
          "${cfg.modifier}+Shift+e" = "mode \"${modeShutdown}\"";

          # Screenshot mode
          "${cfg.modifier}+Print" = "mode \"${modeScreenshot}\"";
          "${cfg.modifier}+Shift+s" = "mode \"${modeScreenshot}\"";

          "${cfg.modifier}+space" = "exec ${pkgs.swayfx}/bin/swaymsg input $(${pkgs.swayfx}/bin/swaymsg -t get_inputs --raw | ${pkgs.jq}/bin/jq '[.[] | select(.type == \"keyboard\")][0] | .identifier') xkb_switch_layout next";

          # Icon picker
          "${cfg.modifier}+Period" = "exec ${glyphs-picker}/bin/glyphs-picker";

          # Multimedia Keys
          "XF86AudioMute" = "exec ${pkgs.pulseaudio}/bin/pactl set-sink-mute @DEFAULT_SINK@ toggle";
          "XF86AudioMicMute" = "exec ${pkgs.pulseaudio}/bin/pactl set-source-mute @DEFAULT_SOURCE@ toggle";
          "--locked XF86MonBrightnessDown" = "exec ${pkgs.brightnessctl}/bin/brightnessctl set 5%-";
          "--locked XF86MonBrightnessUp" = "exec ${pkgs.brightnessctl}/bin/brightnessctl set +5%";
          "XF86AudioRaiseVolume" = "exec ${pkgs.pulseaudio}/bin/pactl set-sink-volume @DEFAULT_SINK@ +5%";
          "XF86AudioLowerVolume" = "exec ${pkgs.pulseaudio}/bin/pactl set-sink-volume @DEFAULT_SINK@ -5%";
          "XF86AudioPlay" = "exec ${pkgs.playerctl}/bin/playerctl play-pause";
          "XF86AudioNext" = "exec ${pkgs.playerctl}/bin/playerctl next";
          "XF86AudioPrev" = "exec ${pkgs.playerctl}/bin/playerctl previous";
        };
        modes = {
          "${modeShutdown}" = {
            "h" = "exec ${pkgs.systemd}/bin/systemctl hibernate && ${pkgs.swayfx}/bin/swaymsg mode default";
            "l" = "exec ${pkgs.swaylock}/bin/swaylock && ${pkgs.swayfx}/bin/swaymsg mode default";
            "e" = "exec ${pkgs.systemd}/bin/loginctl terminate-user $USER && ${pkgs.swayfx}/bin/swaymsg mode default";
            "r" = "exec ${pkgs.systemd}/bin/systemctl reboot && ${pkgs.swayfx}/bin/swaymsg mode default";
            "u" = "exec ${pkgs.systemd}/bin/systemctl suspend && ${pkgs.swayfx}/bin/swaymsg mode default";
            "s" = "exec ${pkgs.systemd}/bin/systemctl poweroff && ${pkgs.swayfx}/bin/swaymsg mode default";
            Escape = "mode default";
            Return = "mode default";
          };
          "${modeScreenshot}" = {
            "r" = "exec ${pkgs.swayfx}/bin/swaymsg mode default && ${pkgs.grim}/bin/grim -g \"$(${pkgs.slurp}/bin/slurp)\" - | ${pkgs.wl-clipboard}/bin/wl-copy";
            "s" = "exec ${pkgs.swayfx}/bin/swaymsg mode default && ${pkgs.grim}/bin/grim -o \"$(${pkgs.swayfx}/bin/swaymsg -t get_outputs | ${pkgs.jq}/bin/jq -r '.[] | select(.focused)' | ${pkgs.jq}/bin/jq -r '.name')\" - | ${pkgs.wl-clipboard}/bin/wl-copy";
            Escape = "mode default";
            Return = "mode default";
          };
          resize = {
            "${cfg.modifier}+${cfg.left}" = "resize shrink width 10px";
            "${cfg.modifier}+${cfg.down}" = "resize grow height 10px";
            "${cfg.modifier}+${cfg.up}" = "resize shrink height 10px";
            "${cfg.modifier}+${cfg.right}" = "resize grow width 10px";

            "${cfg.modifier}+Left" = "resize shrink width 10px";
            "${cfg.modifier}+Down" = "resize grow height 10px";
            "${cfg.modifier}+Up" = "resize shrink height 10px";
            "${cfg.modifier}+Right" = "resize grow width 10px";

            "${cfg.modifier}+Shift+${cfg.left}" = "resize shrink width 50px";
            "${cfg.modifier}+Shift+${cfg.down}" = "resize grow height 50px";
            "${cfg.modifier}+Shift+${cfg.up}" = "resize shrink height 50px";
            "${cfg.modifier}+Shift+${cfg.right}" = "resize grow width 50px";

            "${cfg.modifier}+Shift+Left" = "resize shrink width 50px";
            "${cfg.modifier}+Shift+Down" = "resize grow height 50px";
            "${cfg.modifier}+Shift+Up" = "resize shrink height 50px";
            "${cfg.modifier}+Shift+Right" = "resize grow width 50px";

            "${cfg.modifier}+minus" = "gaps inner current minus 5px";
            "${cfg.modifier}+plus" = "gaps inner current plus 5px";

            Escape = "mode default";
            Return = "mode default";
          };
        };
      };
    };
}
