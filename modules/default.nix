# vim: expandtab:ai:ts=2:sw=2
# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ pkgs, inputs, ... }:

{
  imports = [
    ./sway.nix
    ./ssh.nix
    ./podman.nix
    ./firewall.nix
    ./mounts.nix
    ./bluetooth.nix
    ./gpg.nix
    ./thunar.nix
    ./ausweisapp.nix
    ./network.nix
    ./virtualisation.nix
    ./displaylink.nix
    ./gtk.nix
    ./fingerprint.nix
    ./secrets.nix
    ./k3s.nix
    ./printing.nix
    ./gc.nix
    ./tailscale.nix
  ];
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nix.package = pkgs.nixVersions.nix_2_19;
  nixpkgs.config.allowUnfree = true;

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Set your time zone.
  time.timeZone = "Europe/Berlin";

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.extraGroups.plugdev = { };
  users.users.markus = {
    isNormalUser = true;
    initialPassword = "password";
    extraGroups = [
      "wheel" # Enable ‘sudo’ for the user.
      "networkmanager"
      "video"
      "dialout"
      "plugdev"
      "libvirtd"
      "vboxusers"
    ];
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJxCiKBrwxQBpIaauYXFzmKea876PZ8Eb8gXn13HMx95 markus-thinkpad"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAING6Jk/Z6MnFY3EOmnSa50jEiswY0UDNywPAIe+0rdHJ markus@markus-desktop"
    ];
  };

  fonts.packages = with pkgs; [
    (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
    google-fonts
    corefonts
    atkinson-hyperlegible
  ];

  services.udev.packages = with pkgs; [
    openocd
    platformio
  ];

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    wget
    inputs.agenix.packages.x86_64-linux.default
  ];

  programs.git.enable = true;

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  documentation.man = {
    enable = true;
    generateCaches = true;
  };

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "22.11"; # Did you read the comment?
}
