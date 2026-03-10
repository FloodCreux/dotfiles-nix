{ ... }:
{
  imports = [
    ../shared/nix.nix
    ./nixpkgs
    ./environment
    ./system
    ./users
    ./homebrew
  ];
}
