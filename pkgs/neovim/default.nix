{ pkgs, pkgs-unstable, lib, ... }:
let
  plugins = (import ./plugins.nix { inherit pkgs pkgs-unstable; });

  configDir = import ./config.nix { inherit pkgs pkgs-unstable lib; };

  neovimConfig = pkgs.neovimUtils.makeNeovimConfig {
    inherit plugins;
    vimAlias = true;
    runtimeDeps = with pkgs; [
      ripgrep
      fzf
      gcc
      fd
      nodejs_22
    ];
  };
in
pkgs.wrapNeovimUnstable pkgs.neovim-unwrapped (neovimConfig // {
  wrapperArgs = (lib.escapeShellArgs neovimConfig.wrapperArgs)
    + " --add-flags '--cmd \"set rtp^=${configDir}\"'"
    + " --add-flags '-u ${configDir}/init.lua'";
  wrapRc = false;
})
