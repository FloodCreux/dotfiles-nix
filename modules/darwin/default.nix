{ ... }:
{
  imports = [
    ../shared/nix.nix
    ./nixpkgs
    ./environment
    ./system
    ./users
    ./curl
    ./fd
    ./gh
    ./go
    ./homebrew
    ./jq
    ./less
    ./nvim
    ./nixd
    ./ocaml
    ./python
    ./ripgrep
    ./rust
    ./scala
    ./tree
    ./yazi
  ];

  # Enable all toggleable modules by default.
  # Machine configs can override these with `modules.<name>.enable = false;`
  modules = {
    go.enable = true;
    nvim.enable = true;
    nixd.enable = true;
    ocaml.enable = true;
    python.enable = true;
    rust.enable = true;
    scala.enable = true;
    yazi.enable = true;
  };
}
