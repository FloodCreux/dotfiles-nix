{
  config,
  lib,
  pkgs,
  ...
}:
{
  options.modules.clang.enable = lib.mkEnableOption "C/C++ tools";

  config = lib.mkIf config.modules.clang.enable {
    home.packages = [ pkgs.cmake ];
  };
}
