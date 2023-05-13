{ pkgs, ... }:

{
  # sway with home manager
  programs.sway = {
    enable = true;
    extraPackages = with pkgs; [
      #wl-clipboard
      #wl-clipboard-x11
      wlr-randr
      #xwayland
      xdg-utils
    ];
  };
  environment.sessionVariables = rec {
    #WLR_RENDERER_ALLOW_SOFTWARE = "1";
    WLR_NO_HARDWARE_CURSORS = "1";
  };
  programs.git.enable = true;

  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  };

  security.polkit.enable = true;
  security.pam.services.swaylock = {
    text = "auth include login";
  };
  hardware.opengl.enable = true;

  # Enable the X11 windowing system.
  services.xserver.enable = false;
}
