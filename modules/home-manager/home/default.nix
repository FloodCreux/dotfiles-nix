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

  # Don't change this unless you know what you're doing
  home.stateVersion = "25.11";

  home.enableNixpkgsReleaseCheck = false;

  imports = [
    ./clang
    ./containers
    ./haskell
    ./java
    ./lua
    ./misc
    ./nix
    ./node
    ./scala
    ./sql
    ./terraform
    ./zig
  ];

  home.sessionVariables = {
    PAGER = "less";
    CLICLOLOR = 1;
    EDITOR = "nvim";
  };
}
