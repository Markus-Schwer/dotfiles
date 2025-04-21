{ pkgs, pkgs-unstable, lib, ... }:
let
  plugins = (import ./plugins.nix { inherit pkgs pkgs-unstable; });

  configDir = import ./config.nix { inherit pkgs pkgs-unstable lib; };

  extraPackages = with pkgs; [
    ripgrep
    fzf
    gcc
    fd
    nodejs_22
  ];

  neovimConfig = pkgs.neovimUtils.makeNeovimConfig {
    inherit plugins;
    vimAlias = false;
  };
in
pkgs.wrapNeovimUnstable pkgs.neovim-unwrapped (neovimConfig // {
  wrapperArgs = (lib.escapeShellArgs neovimConfig.wrapperArgs)
    + " --suffix PATH : \"${lib.makeBinPath extraPackages}\""
    + " --add-flags '--cmd \"set rtp^=${configDir}\"'"
    + " --add-flags '-u ${configDir}/init.lua'";
  wrapRc = false;
})
