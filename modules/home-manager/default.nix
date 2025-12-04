{
  pkgs,
  username,
  lib,
  extraHomePackages ? [ ],
  ...
}:
let
  # Helper to import modules with pkgs or username
  importWith = path: args: import path args;
  # importUsername = path: importWith path { inherit username; };
  importPkgs = path: importWith path { inherit pkgs; };
  importAll =
    path:
    importWith path {
      inherit pkgs;
      inherit username;
      inherit lib;
    };
in
{
  # Merge machine-specific home packages with core configuration
  home.packages = extraHomePackages;

  imports = [
    (importAll ./home)
    (importPkgs ./bat)
    ./carapace
    ./direnv
    ./eza
    ./fzf
    ./git
    ./neofetch
    ./nushell
    ./ohmyposh
    ./password-store
    ./starship
    (importPkgs ./tmux)
    ./zellij
    ./zsh
  ];
}
