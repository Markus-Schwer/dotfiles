{ pkgs, ... }:
{
  home.packages = with pkgs; [
    vim
    neovim
    postgresql_17
    llama-cpp
  ];
}
