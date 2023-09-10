{ pkgs, ... }:

{
  home.packages = with pkgs; [
    protonmail-bridge
    pass-wayland
  ];

  services.pass-secret-service.enable = true;
  systemd.user.services.protonmail = {
    Unit = {
      Description = "Protonmail Bridge";
      Requires = [ "pass-secret-service.service" "gpg-agent.socket" ];
    };
    Service = {
      Restart = "always";
      ExecStart = "${pkgs.protonmail-bridge}/bin/protonmail-bridge --noninteractive";
      Environment = [
        "PATH=${pkgs.pass-wayland}/bin"
      ];
    };
    Install = {
      WantedBy = [ "default.target" ];
    };
  };
}
