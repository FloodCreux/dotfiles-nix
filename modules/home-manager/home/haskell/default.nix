{ pkgs, ... }:
{
  home.packages = with pkgs; [
    elixir
    elixir-ls
    ghc
    cabal-install
    # stack
  ];
}
