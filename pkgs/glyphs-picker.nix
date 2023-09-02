{ pkgs }:

pkgs.writeShellScriptBin "glyphs-picker" ''
  glyphs_file="${./glyphs.csv}"
  readarray chars < "''${glyphs_file}"
  char_entry=''$(
    for char in "''${chars[@]}"; {
      echo ''${char/,/ }
    } | ${pkgs.wofi}/bin/wofi -dmenu
  )
  # exit if user canceled selection
  [ -z "''${char_entry}" ] && exit

  char="''${char_entry% *}"

  # copy character to clipboard
  printf "%s" ''${char} | ${pkgs.wl-clipboard}/bin/wl-copy
''
