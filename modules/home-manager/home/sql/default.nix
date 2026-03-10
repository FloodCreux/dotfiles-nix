{
  config,
  lib,
  pkgs,
  ...
}:
{
  options.modules.sql.enable = lib.mkEnableOption "SQL tools";

  config = lib.mkIf config.modules.sql.enable {
    home.packages = [ pkgs.sqlite ];
  };
}
