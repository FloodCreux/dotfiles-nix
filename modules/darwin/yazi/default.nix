{
  config,
  lib,
  pkgs,
  ...
}:
{
  options.modules.yazi.enable = lib.mkEnableOption "Yazi file manager";

  config = lib.mkIf config.modules.yazi.enable {
    environment.systemPackages = [ pkgs.yazi ];
  };
}
