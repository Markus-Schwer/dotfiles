{ pkgs, nix-versions, ... }:
{
  home.packages = with pkgs; [
    vim
    neovim
    postgresql_17
    llama-cpp
    nix-versions.packages.${system}.default
  ];
}
