{ pkgs, username, ... }:
{
  imports = [
    ./home
    ./bat
    ./carapace
    ./direnv
    ./eza
    ./fzf
    ./git
    (import ./java { inherit pkgs; })
    ./nushell
    ./ohmyposh
    ./password-store
    ./starship
    ./tmux
    (import ./wezterm { inherit username; })
    ./zellij
    ./zsh
  ];
}
