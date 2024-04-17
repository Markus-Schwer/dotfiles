{ pkgs, ... }: {
  services.printing = {
    enable = true;
    drivers = [ pkgs.hplip ];
  };
  hardware.printers.ensurePrinters = [{
    name = "Space-2D-Drucker";
    model = "HP/hp-color_laserjet_mfp_m480-ps.ppd.gz";
    deviceUri = "socket://2d.sfz-aalen.space";
    ppdOptions = {
      PageSize = "A4";
    };
  }];
  services.avahi = {
    enable = true;
    nssmdns = true;
    openFirewall = true;
  };
}
