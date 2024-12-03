{ pkgs, username, ... }:

let
  nix = import ../shared/nix.nix;
in
{
  nix = nix;

  imports = [
    ./nixpkgs
    (import ./environment {
      inherit pkgs;
      inherit username;
    })
    ./system
    ./services
    (import ./users { inherit username; })
    ./homebrew
    ./zsh
  ];

}
