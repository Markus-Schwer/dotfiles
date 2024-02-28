 {
    services.fprintd.enable = true;

    security.pam.services.swaylock.fprintAuth = false;
    security.pam.services.login.fprintAuth = true;
    security.pam.services.sudo.fprintAuth = true;
}
