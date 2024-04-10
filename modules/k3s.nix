{ pkgs, ...}:
{
  services.k3s.enable = true;
  services.k3s.role = "server";
  environment.systemPackages = with pkgs; [ k3s ];
}
