{
  config,
  lib,
  pkgs,
  ...
}:
{
  options.modules.node.enable = lib.mkEnableOption "Node.js";

  config = lib.mkIf config.modules.node.enable {
    home.packages = with pkgs.nodePackages; [
      vscode-json-languageserver
      (lib.lowPrio prettier)
    ];
  };
}
