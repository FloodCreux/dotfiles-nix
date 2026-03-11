{
  config,
  lib,
  pkgs,
  ...
}:
{
  options.modules.java.enable = lib.mkEnableOption "Java";

  config = lib.mkIf config.modules.java.enable {
    home.packages = [ pkgs.jdk21 ];

    home.sessionVariables = {
      JAVA_HOME = "${pkgs.jdk21}";
    };
  };
}
