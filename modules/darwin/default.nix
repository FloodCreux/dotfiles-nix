{ pkgs, username, ... }:

let
  nix = import ../shared/nix.nix;

  # Helper to import modules with pkgs or username
  importWith = path: args: import path args;
  importPkgs = path: importWith path { inherit pkgs; };
  importUsername = path: importWith path { inherit username; };

in
{
  nix = nix;

  imports = [
    ./nixpkgs
    (importUsername ./environment)
    ./system
    ./services
    (importUsername ./users)
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
    (importPkgs ./ripgrep)
    (importPkgs ./yazi)
    (importPkgs ./zig)
    ./zsh
    ./homebrew
  ];
}
