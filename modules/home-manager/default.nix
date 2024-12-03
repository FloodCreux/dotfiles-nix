{ username, ... }:
{
  imports = [
    ./home
    ./bat
    ./carapace
    ./direnv
    ./eza
    ./fzf
    ./git
    ./java
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
