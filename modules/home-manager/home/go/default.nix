{
  config,
  lib,
  pkgs,
  ...
}:
{
  options.modules.go.enable = lib.mkEnableOption "Go";

  config = lib.mkIf config.modules.go.enable {
    home.packages = [ pkgs.go ];
  };
}
