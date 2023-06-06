{ pkgs, ... }:

{
  programs.neovim = {
    enable = true;
    vimAlias = true;
    extraConfig = ''
      :luafile ~/.config/nvim/lua/init.lua
    '';
    plugins = import ./plugins.nix { inherit pkgs; };
  };

  # set nvim as the default editor
  home.sessionVariables = { EDITOR = "nvim"; };

  xdg.configFile.nvim = {
    source = ./config;
    recursive = true;
  };
}
