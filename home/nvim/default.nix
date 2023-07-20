{ pkgs, ... }:

{
  programs.neovim = {
    enable = true;
    vimAlias = true;
    extraConfig = ''
      :luafile ~/.config/nvim/lua/markus/init.lua
    '';
    plugins = import ./plugins.nix { inherit pkgs; };
    extraPackages = with pkgs; [
      gcc
      glibc
      lua-language-server
      nil
      rust-analyzer
      ripgrep
      clang-tools
      ccls
    ];
  };

  # set nvim as the default editor
  home.sessionVariables = { EDITOR = "nvim"; };

  xdg.configFile.nvim = {
    source = ./config;
    recursive = true;
  };
}
