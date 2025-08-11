{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    tree
    tree-sitter
  ];
}
