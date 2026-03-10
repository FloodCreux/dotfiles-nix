{
  config,
  lib,
  pkgs,
  ...
}:
{
  options.modules.lua.enable = lib.mkEnableOption "Lua";

  config = lib.mkIf config.modules.lua.enable {
    home.packages = with pkgs; [
      stylua
      lua
    ];
  };
}
