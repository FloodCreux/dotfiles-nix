{ pkgs, ... }:
{
  home.packages = [
    pkgs.zsh
  ];

  home.file.".zshenv".source = ./zshenv;
}
