{ pkgs, username, ... }:
let
  # Helper to import modules with pkgs or username
  importWith = path: args: import path args;
  importPkgs = path: importWith path { inherit pkgs; };
  importUsername = path: importWith path { inherit username; };
in
{
  imports = [
    ./home
    (importPkgs ./bat)
    ./carapace
    ./direnv
    ./eza
    ./fzf
    ./git
    (importPkgs ./java)
    ./nushell
    ./ohmyposh
    ./password-store
    ./starship
    (importPkgs ./tmux)
    (importUsername ./wezterm)
    ./zellij
    ./zsh
  ];
}
