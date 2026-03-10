{
  config,
  lib,
  pkgs,
  ...
}:
{
  options.modules.nvim.enable = lib.mkEnableOption "Neovim";

  config = lib.mkIf config.modules.nvim.enable {
    environment.systemPackages = [ pkgs.neovim ];
  };
}
