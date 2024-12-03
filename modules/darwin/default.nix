{ pkgs, username, ... }:

let
  nix = import ../shared/nix.nix;
in
{
  nix = nix;

  imports = [
    ./nixpkgs
    (import ./environment {
      inherit username;
    })
    ./system
    ./services
    (import ./users { inherit username; })
    (import ./carapace { inherit pkgs; })
    (import ./curl { inherit pkgs; })
    (import ./fd { inherit pkgs; })
    (import ./gh { inherit pkgs; })
    (import ./jq { inherit pkgs; })
    (import ./lazygit { inherit pkgs; })
    (import ./less { inherit pkgs; })
    (import ./nvim { inherit pkgs; })
    (import ./nixd { inherit pkgs; })
    (import ./nushell { inherit pkgs; })
    (import ./ripgrep { inherit pkgs; })
    (import ./yazi { inherit pkgs; })
    (import ./zig { inherit pkgs; })
    ./zsh
    ./homebrew
  ];

}
