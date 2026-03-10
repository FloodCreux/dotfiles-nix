{
  config,
  lib,
  pkgs,
  ...
}:
{
  options.modules.go.enable = lib.mkEnableOption "Go";
  config = lib.mkIf config.modules.go.enable {
    environment.systemPackages = with pkgs; [ go ];
  };
}
