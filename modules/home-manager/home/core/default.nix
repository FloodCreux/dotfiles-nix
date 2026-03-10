# Core tools — always installed on every machine.
# These are fundamental CLI utilities and formatters that every config needs.
{ pkgs, ... }:
{
  home.packages = with pkgs; [
    coreutils
    curl
    fd
    gh
    jq
    less
    ripgrep
    tree
    tree-sitter

    # Nix tooling
    nixfmt

    # Misc utilities
    chafa
    utf8proc
    lz4
  ];
}
