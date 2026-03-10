{
  pkgs,
  lib,
  username,
  ...
}:

{
  nixpkgs.config = {
    allowUnfree = true;
    allowUnsupportedSystem = true;
  };

  home.stateVersion = "25.11";

  home.enableNixpkgsReleaseCheck = false;

  imports = [
    ./clang
    ./haskell
    ./java
    ./lua
    ./misc
    ./nix
    ./node
    ./scala
    ./sql
  ];

  home.sessionVariables = {
    PAGER = "less";
    CLICLOLOR = 1;
    EDITOR = "nvim";
  };
}
