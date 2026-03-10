{ ... }:
{
  home.stateVersion = "25.11";

  home.enableNixpkgsReleaseCheck = false;

  imports = [
    # Always-on core tools
    ./core

    # Toggleable language/tool modules
    ./clang
    ./elixir
    ./go
    ./hadoop
    ./haskell
    ./java
    ./lua
    ./nixd
    ./node
    ./nvim
    ./ocaml
    ./python
    ./rust
    ./scala
    ./sql
    ./yazi
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
    go.enable = true;
    hadoop.enable = true;
    haskell.enable = true;
    java.enable = true;
    lua.enable = true;
    nixd.enable = true;
    node.enable = true;
    nvim.enable = true;
    ocaml.enable = true;
    python.enable = true;
    rust.enable = true;
    scala.enable = true;
    sql.enable = true;
    yazi.enable = true;
  };
}
