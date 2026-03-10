{
  config,
  lib,
  pkgs,
  ...
}:
{
  options.modules.nixd.enable = lib.mkEnableOption "Nix language servers (nixd, nil)";

  config = lib.mkIf config.modules.nixd.enable {
    environment.systemPackages = with pkgs; [
      nixd
      nil
    ];
  };
}
