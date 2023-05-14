{ pkgs, ... }:

{
  programs.neovim = {
    enable = true;
    vimAlias = true;
    #extraConfig = import ./config { inherit pkgs; };
    plugins = import ./plugins.nix { inherit pkgs; };
    #runtimeDeps = import ./runtimeDeps.nix { inherit pkgs; };
    #extraPackages = import ./runtimeDeps.nix { inherit pkgs; };
  };

  # set nvim as the default editor
  home.sessionVariables = { EDITOR = "nvim"; };
}
