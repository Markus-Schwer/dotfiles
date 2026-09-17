{ nixos-hardware, disko }:
[
  {
    name = "nixwork";
    system = "x86_64-linux";
    nixosModules = [
      disko.nixosModules.disko
      nixos-hardware.nixosModules.framework-13-7040-amd
      ./hardware/framework-13-inch-7040-amd.nix
      (import ./disko-config.nix { disk = "/dev/nvme0n1"; })
      {
        markus.network = {
          hostname = "nixwork";
          hostid = "19dba1ec";
        };
      }
    ];
  }
  {
    name = "thinknix";
    system = "x86_64-linux";
    nixosModules = [
      disko.nixosModules.disko
      nixos-hardware.nixosModules.lenovo-thinkpad-t495
      ./hardware/thinkpad-t495.nix
      (import ./disko-config.nix { disk = "/dev/nvme0n1"; })
      {
        markus.network = {
          hostname = "thinknix";
          hostid = "a167e424";
        };
      }
    ];
  }
  {
    name = "desktop";
    system = "x86_64-linux";
    nixosModules = [
      ./hardware/desktop.nix
      {
        markus.network = {
          hostname = "nixpad";
          hostid = "a167e424";
        };
      }
    ];
  }
  {
    name = "workmac";
    system = "aarch64-darwin";
    homeManagerModules = [
      {
        home = {
          username = "schwerm";
          homeDirectory = "/Users/schwerm";
          stateVersion = "24.11";

          # set nvim as the default editor
          sessionVariables = { EDITOR = "nvim"; };
        };

        programs.home-manager.enable = true;
        programs.zsh.enable = true;
        programs.tmux.shell = "/bin/zsh";

        fonts.fontconfig.enable = true;

        imports = [
          ./home/tmux.nix
          ./home/mac.nix
        ];
      }
    ];
    nixosModules = [];
  }
  {
    name = "workubuntu";
    system = "x86_64-linux";
    homeManagerModules = [
      {
        home = {
          username = "schwerm";
          homeDirectory = "/home/schwerm";
        };

        targets = {
          # Make home-manager work better on non-NixOS
          genericLinux.enable = true;
        };

        wayland.windowManager.sway = {
          config = {
            startup = [
              { command = "/home/schwerm/.nix-profile/bin/firefox"; }
              { command = "dex /home/schwerm/.local/share/applications/chrome-ilbcbhpbmggihnbldpmmbppiclfnifck-Profile_1.desktop"; } # TIDAL
              { command = "dex /home/schwerm/.local/share/applications/chrome-fmgjjmmmlfnkbppncabfkddbjimcfncm-Profile_1.desktop"; } # Gmail
              { command = "dex /home/schwerm/.local/share/applications/chrome-kjbdgfilnfhdoflbpgamdcdgpehopbep-Profile_1.desktop"; } # Google Kalender
              { command = "dex /home/schwerm/.local/share/applications/chrome-pommaclcbfghclhalboakcipcmmndhcj-Profile_1.desktop"; } # Google Chat
              { command = "dex /home/schwerm/.local/share/applications/chrome-kjgfgldnnfoeklkmfkjfagphfepbbdan-Profile_1.desktop"; } # Google Meet
            ];
            assigns = {
              "1" = [
                { app_id = "firefox"; }
                { app_id = "google-chrome"; }
              ];
              "2" = [
                { app_id = "chrome-ilbcbhpbmggihnbldpmmbppiclfnifck-Profile_1"; } # TIDAL
                { app_id = "chrome-fmgjjmmmlfnkbppncabfkddbjimcfncm-Profile_1"; } # Gmail
                { app_id = "chrome-kjbdgfilnfhdoflbpgamdcdgpehopbep-Profile_1"; } # Google Kalender
                { app_id = "chrome-pommaclcbfghclhalboakcipcmmndhcj-Profile_1"; } # Google Chat
                { app_id = "chrome-kjgfgldnnfoeklkmfkjfagphfepbbdan-Profile_1"; } # Google Meet
              ];
            };
          };
        };

        # use ubuntu swaylock for compatibility with ubuntu pam
        programs.swaylock.package = null;
        services.swayidle = {
          events = [
            { event = "lock"; command = "/usr/bin/swaylock"; }
            { event = "before-sleep"; command = "/usr/bin/swaylock"; }
          ];
          timeouts = [
            { timeout = 600; command = "/usr/bin/swaylock"; }
          ];
        };

        imports = [
          ./home
        ];
      }
    ];
    nixosModules = [];
  }
]
