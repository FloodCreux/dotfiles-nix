{
  config,
  lib,
  pkgs,
  ...
}:
{
  options.modules.hadoop.enable = lib.mkEnableOption "Hadoop";

  config = lib.mkIf config.modules.hadoop.enable {
    home.packages = [ pkgs.hadoop ];
  };
}
