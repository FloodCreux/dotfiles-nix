{ pkgs, lib, ... }:
{
  home.packages = with pkgs.nodePackages; [
    vscode-json-languageserver
    (lib.lowPrio prettier)
  ];
}
