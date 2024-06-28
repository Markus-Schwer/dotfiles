{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [ xarchiver davfs2 ];
  programs.thunar.enable = true;
  programs.thunar.plugins = with pkgs.xfce; [
    thunar-archive-plugin
    thunar-volman
  ];
  services.gvfs.enable = true; # Mount, trash, and other functionalities
  services.davfs2.enable = true; # WebDav support (e.g. NextCloud)
  services.tumbler.enable = true; # Thumbnail support for images
}
