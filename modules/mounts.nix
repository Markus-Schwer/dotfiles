{ pkgs, ... }:

{
  services.rpcbind.enable = true; # needed for NFS
  # For mount.cifs, required unless domain name resolution is not needed.
  environment.systemPackages = [ pkgs.cifs-utils ];

  services.davfs2 = {
    enable = true;
    settings = {
      globalSection = {
        ignore_dav_header = true;
      };
    };
  };

  fileSystems."/mnt/talos" = {
    fsType = "nfs";
    device = "10.20.42.50:/talos";
    options = [
      "x-systemd.automount"
      "noauto"
      "x-systemd.idle-timeout=600" # disconnects after 10 minutes (i.e. 600 seconds)
    ];
  };

  fileSystems."/mnt/k3s" = {
    fsType = "nfs";
    device = "10.20.42.50:/kubernetes";
    options = [
      "x-systemd.automount"
      "noauto"
      "x-systemd.idle-timeout=600" # disconnects after 10 minutes (i.e. 600 seconds)
    ];
  };

  fileSystems."/mnt/lasercutter" = {
    fsType = "nfs";
    device = "10.20.42.50:/Lasercutter";
    options = [
      "x-systemd.automount"
      "noauto"
      "x-systemd.idle-timeout=600" # disconnects after 10 minutes (i.e. 600 seconds)
    ];
  };

  fileSystems."/mnt/music" = {
    fsType = "nfs";
    device = "10.20.42.50:/Music";
    options = [
      "x-systemd.automount"
      "noauto"
      "x-systemd.idle-timeout=600" # disconnects after 10 minutes (i.e. 600 seconds)
    ];
  };
}
