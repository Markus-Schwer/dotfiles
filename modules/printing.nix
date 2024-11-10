{ pkgs, ... }: {
  services.printing = {
    enable = true;
    drivers = with pkgs; [ hplip canon-cups-ufr2 ];
  };
  hardware.printers.ensurePrinters = [
    {
      name = "Space-2D-Drucker";
      model = "HP/hp-color_laserjet_mfp_m480-ps.ppd.gz";
      deviceUri = "socket://10.11.42.10";
      ppdOptions = {
        PageSize = "A4";
      };
    }
    {
      name = "Space-Weisstoner-Drucker";
      model = "HP/hp-color_laserjet_mfp_m480-ps.ppd.gz";
      deviceUri = "socket://10.11.42.12";
      ppdOptions = {
        PageSize = "A4";
      };
    }
  ];
  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
  };
}
