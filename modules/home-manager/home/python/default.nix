{
  config,
  lib,
  pkgs,
  ...
}:
{
  options.modules.python.enable = lib.mkEnableOption "Python";

  config = lib.mkIf config.modules.python.enable {
    home.packages = [ pkgs.pipx ];
  };
}
