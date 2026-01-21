{ pkgs, ... }:
{
  # used to set up system wide configuration, actual configuration happens in
  # home-manager
  programs.sway = {
    enable = true;
    wrapperFeatures.gtk = true;
  };

  xdg.portal = {
    enable = true;
    config.common.default = "*";
    extraPortals = with pkgs; [
      xdg-desktop-portal-wlr
      xdg-desktop-portal-gtk
    ];
    wlr.enable = true;
    xdgOpenUsePortal = true;
  };

  security.polkit.enable = true;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    pulse.enable = true;
  };
  services.pipewire.configPackages = [
    (pkgs.writeTextDir "share/pipewire/pipewire.conf.d/99-pulseaudio-native-tcp.conf" ''
      context.modules = [
        {
          name = libpipewire-module-zeroconf-discover
          args = {}
        }
        {
          name = libpipewire-module-pulse-tunnel
          args = {
            tunnel.mode = sink
          }
        }
      ]
    '')
  ];

  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${pkgs.greetd}/bin/agreety --cmd sway";
      };
    };
  };
}
