{
  config,
  lib,
  pkgs,
  ...
}:
{
  options.modules.scala.enable = lib.mkEnableOption "Scala";

  config = lib.mkIf config.modules.scala.enable {
    home.packages = with pkgs; [
      sbt
      metals
      coursier
      maven
      (lib.hiPrio scala_2_13)
      scalafmt
    ];
  };
}
