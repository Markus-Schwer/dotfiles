{ pkgs, ... }:
{
  services.fprintd.enable = true;

  security.pam.services.swaylock = {
    fprintAuth = false;
    text = ''
      auth sufficient ${pkgs.linux-pam}/lib/security/pam_unix.so try_first_pass likeauth nullok
      auth sufficient ${pkgs.fprintd}/lib/security/pam_fprintd.so max-tries=1 timeout=1
      auth include login
    '';
  };

  # this needs to be set to false, so that the timeout for fprintd in the swaylock config works
  security.pam.services.login.fprintAuth = false;
  security.pam.services.sudo.fprintAuth = true;
}
