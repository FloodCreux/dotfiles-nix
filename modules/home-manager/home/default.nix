{
  pkgs,
  username,
  lib,
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
    ./elixir
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
    CLICOLOR = 1;
    EDITOR = "nvim";
  };

  catppuccin = {
    enable = true;
    flavor = "macchiato";
    accent = "mauve";

    bat = {
      enable = true;
    };
  };
}
