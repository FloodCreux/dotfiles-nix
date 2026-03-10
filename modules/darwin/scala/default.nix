{
  config,
  lib,
  pkgs,
  ...
}:
{
  options.modules.scala.enable = lib.mkEnableOption "Scala";

  config = lib.mkIf config.modules.scala.enable {
    environment.systemPackages = [ pkgs.sbt ];
  };
}
