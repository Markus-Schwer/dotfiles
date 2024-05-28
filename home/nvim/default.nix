{ pkgs, pkgs-unstable, lib, nixpkgs, ... }:

let
  getDir = dir: lib.attrsets.mapAttrs
    (file: type:
      if type == "directory" then getDir "${dir}/${file}" else builtins.readFile "${dir}/${file}"
    )
    (builtins.readDir dir);

  getLeaveFiles = dir: builtins.listToAttrs (lib.collect (x: x ? value) (lib.attrsets.mapAttrsRecursive
    (path: value: lib.nameValuePair (lib.concatStringsSep "/" path) value)
    (getDir dir))
  );

  getAndImportNixFiles = dir: lib.mapAttrs'
    (name: value:
      lib.nameValuePair
        (lib.strings.removeSuffix ".nix" name)
        (import "${dir}/${name}" { inherit pkgs pkgs-unstable nixpkgs; }))
    (lib.filterAttrs (name: value: lib.strings.hasSuffix ".nix" name) (getLeaveFiles dir));

  getNonNixFiles = dir: lib.filterAttrs (name: value: ! lib.strings.hasSuffix ".nix" name) (getLeaveFiles dir);

  addFilePrefix = prefix: files: lib.mapAttrs' (name: value: lib.nameValuePair (prefix + name) { text = value; }) files;

  xdgImportDir = xdgPrefix: dir: addFilePrefix "${xdgPrefix}/" (lib.attrsets.mergeAttrsList [ (getNonNixFiles dir) (getAndImportNixFiles dir) ]);
in
{
  programs.neovim = {
    enable = true;
    vimAlias = true;
    extraConfig = ''
      :luafile ~/.config/nvim/lua/markus/init.lua
    '';
    plugins = import ./plugins.nix { inherit pkgs pkgs-unstable; };
    extraPackages = with pkgs; [
      ripgrep
      fzf
      gcc
      fd
      nodejs_21
    ];
  };

  # set nvim as the default editor
  home.sessionVariables = { EDITOR = "nvim"; };

  xdg.configFile = xdgImportDir "nvim" ./config;
}
