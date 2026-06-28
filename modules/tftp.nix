{
  services.atftpd.enable = true;
  networking.firewall.allowedUDPPorts = [69]; # TFTP
  networking.firewall.allowedTCPPorts = [8000]; # Python http.server
}

