{
  services.gnome.gnome-keyring.enable = true;
  services.gnome.gcr-ssh-agent.enable = false;
  security.pam.services.login.enableGnomeKeyring = true;
  programs.seahorse.enable = true;
}
