{ lib, ... }:
with lib;
{
  options.markus.theme = mkOption {
    type = types.enum [ "dark" "light" ];
    default = "dark";
  };
}

