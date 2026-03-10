{ ... }:
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

  # Enable all toggleable modules by default.
  # Machine configs can override these with `modules.<name>.enable = false;`
  modules = {
    clang.enable = true;
    elixir.enable = true;
    haskell.enable = true;
    java.enable = true;
    lua.enable = true;
    node.enable = true;
    scala.enable = true;
    sql.enable = true;
  };
}
