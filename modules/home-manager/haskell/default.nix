{ pkgs, ... }:
{
  home.packages = with pkgs; [
    haskellPackages.ghcWithPackages
    cabal-install
    stack
  ];
}
