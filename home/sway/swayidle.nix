{ pkgs, lib, ... }:

{
  services.swayidle = {
    enable = true;
    systemdTargets = [ "sway-session.target" ];
    events = [
      { event = "lock"; command = lib.mkDefault "${pkgs.swaylock}/bin/swaylock"; }
      { event = "before-sleep"; command = lib.mkDefault "${pkgs.swaylock}/bin/swaylock"; }
      { event = "after-resume"; command = lib.mkDefault "${pkgs.swayfx}/bin/swaymsg \"output * toggle\""; }
    ];
    timeouts = [
      { timeout = 600; command = lib.mkDefault "${pkgs.swaylock}/bin/swaylock"; }
      { timeout = 1200; command = lib.mkDefault "${pkgs.swayfx}/bin/swaymsg \"output * toggle\""; }
    ];
  };
}

