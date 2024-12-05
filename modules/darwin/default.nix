{ pkgs, username, ... }:

let
  nix = import ../shared/nix.nix;

  # Helper to import modules with pkgs or username
  importWith = path: args: import path args;
  importPkgs = path: importWith path { inherit pkgs; };
  # importUsername = path: importWith path { inherit username; };
  importAll =
    path:
    importWith path {
      inherit pkgs;
      inherit username;
    };

in
{
  nix = nix;

  imports = [
    ./nixpkgs
    (importPkgs ./environment)
    ./system
    ./services
    (importAll ./users)
    (importPkgs ./carapace)
    (importPkgs ./curl)
    (importPkgs ./fd)
    (importPkgs ./gh)
    (importPkgs ./jq)
    (importPkgs ./lazygit)
    (importPkgs ./less)
    (importPkgs ./nvim)
    (importPkgs ./nixd)
    (importPkgs ./nushell)
    (importPkgs ./ocaml)
    (importPkgs ./python)
    (importPkgs ./ripgrep)
    (importPkgs ./rust)
    (importPkgs ./scala)
    (importPkgs ./yazi)
    (importPkgs ./zig)
    ./zsh
    ./homebrew
  ];
}
