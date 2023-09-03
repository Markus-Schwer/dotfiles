{ pkgs, ... }:
{
  programs.waybar = {
    enable = true;
    # experimental flag is necessary for wlr workspaces module
    package = pkgs.waybar.overrideAttrs (oa: {
      mesonFlags = (oa.mesonFlags or  [ ]) ++ [ "-Dexperimental=true" ];
    });
    systemd.enable = true;
    settings = {
      foo = {
        layer = "top";
        modules-left = [ "custom/nixstore" "wlr/workspaces" "hyprland/submap" ];
        modules-right = [ "clock" "hyprland/language" "network" "bluetooth" "backlight" "pulseaudio" "cpu" "custom/coretemp" "memory" "battery" ];

        # modules
        network = {
          interval = 5;
          format-wifi = " ";
          format-ethernet = "󰈀";
          format-disconnected = "󰖪";
          tooltip-format = "{icon} {ifname} = {ipaddr}";
          tooltip-format-ethernet = "{icon} {ifname} = {ipaddr}";
          tooltip-format-wifi = "{icon} {ifname} ({essid}) = {ipaddr}";
          tooltip-format-disconnected = "{icon} disconnected";
          tooltip-format-disabled = "{icon} disabled";
        };
        "custom/nixstore" = {
          exec = "${pkgs.coreutils}/bin/du -sh /nix/store | ${pkgs.gnused}/bin/sed 's/\\([0-9]\\+[A-Z]\\+\\).*/\\1/'";
          interval = 300;
          format = "STORE: {}";
          tooltip = false;
        };
        "custom/coretemp" = {
          exec = "${pkgs.lm_sensors}/bin/sensors | ${pkgs.gnugrep}/bin/grep 'Package id 0:' | ${pkgs.gnused}/bin/sed 's/^Package id 0:  +//' | ${pkgs.gnused}/bin/sed 's/\\.[0-9]°C[ ]\\+.*$//'";
          interval = 10;
          format = " {}°C |";
          tooltip = false;
        };
        backlight = {
          format = "{icon} {percent}%";
          format-icons = ["󰃞" "󰃟" "󰃠"];
        };
        pulseaudio = {
          scroll-step = 5;
          format = "{icon} {volume}%{format_source}";
          format-muted = "󰖁 {format_source}";
          format-source = "";
          format-source-muted = " 󰍭";
          format-icons = {
              headphone = "󰋋";
              headset = "󰋎";
              default = ["󰕿" "󰖀" "󰕾"];
          };
          tooltip-format = "{icon}  {volume}% {format_source}";
          on-click = "${pkgs.pulseaudio}/bin/pulseaudio";
        };
        cpu = {
          format = "󰍛 {usage}%";
        };
        memory = {
          format = "󰘚 {percentage}%";
          tooltip = false;
        };
        bluetooth = {
          format-on = "BLUE: 󰂯";
          format-connected = "BLUE: 󰂯 {num_connections}";
          format-off = "BLUE: 󰂲";
        };
        "hyprland/language" = {
          format = "  {} |";
          /* format-en = "EN/US"; */
        };
        "wlr/workspaces" = {
          format = "{icon}";
          on-click = "activate";
        };
        "hyprland/submap" = {
          tooltip = true;
        };
        clock = {
          interval = 60;
          format = "{:%e %b %Y %H:%M} |";
          tooltip = true;
          tooltip-format = "<big>{:%B %Y}</big>\n<tt>{calendar}</tt>";
        };
        battery = {
          states = {
            warning = 30;
            critical = 15;
          };
          format = "{capacity}% {icon}";
          format-icons = ["" "" "" "" ""];
        };
      };
    };
    style = ./bar.css;
  };
}
