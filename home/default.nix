{ pkgs, pkgs-unstable, theme, ... }:

let
  glyphs-picker = import ../pkgs/glyphs-picker.nix { inherit pkgs; };
in
{
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "markus";
  home.homeDirectory = "/home/markus";

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "23.05";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  home.packages = with pkgs; [
    killall
    firefox
    gimp
    spice-vdagent
    neofetch
    alacritty # gpu accelerated terminal
    mako # notification system
    bemenu # launch menu
    openvpn
    element-desktop #-wayland
    terraform
    nmap
    signal-desktop
    pkgs-unstable.freecad
    drawio
    cargo
    rustc
    spotifywm
    inkscape
    fluxcd
    kubeseal
    chromium
    platformio
    usbutils
    glyphs-picker
    hyprpicker
    wl-clipboard
    solvespace
    pkgs-unstable.teams-for-linux
    remmina
    webcamoid
    bluetuith
    pulsemixer
    vlc
    libreoffice
    rpi-imager
    pkgs-unstable.btop
    pciutils
    pkgs-unstable.arduino-ide
    prusa-slicer
    unzip
    zathura # pdf viewer
    bruno
    pkgs-unstable.dune3d
    eog
    tailscale
    pdfarranger
    kubectl-view-secret
    pwgen
    tldr
    waypipe
    wayvnc
    bitwarden-desktop
    postgresql
    beekeeper-studio
    jameica
    keystore-explorer
    nextcloud-client
    openscad
    delve
    age
    sops
    pkgs-unstable.usbkvm
    python3
    pavucontrol
    neofetch
    packer
    gnome-network-displays
    telegram-desktop
    neovim
    rawtherapee
    gnumake
  ];
  home.pointerCursor = {
    # https://github.com/NixOS/nixpkgs/issues/207496
    package = pkgs.vanilla-dmz;
    name = "Vanilla-DMZ";
    gtk.enable = true;
  };

  xdg.enable = true;

  # set nvim as the default editor
  home.sessionVariables = { EDITOR = "nvim"; };

  programs.bash.enable = true;
  programs.bash.shellAliases = {
    pretty_json = "${pkgs.jq}/bin/jq -Rr '. as $line | (fromjson? | select(type == \"object\") | .stackTrace //= \"\" | .message, .stackTrace) // $line'";
  };

  markus.theme = theme;

  imports = [
    ./sway
    ./kubectl.nix
    ./go.nix
    ./kdeconnect.nix
    ./gpg.nix
    ./protonmail.nix
    ./gtk.nix
    ./sourcegraph.nix
    ./mail.nix
    ./theme.nix
    ./tmux.nix
    ./gc.nix
  ];
}
