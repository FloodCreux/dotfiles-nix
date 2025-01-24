{ pkgs, ... }:
{
  programs.tmux = {
    enable = false;
    shell = "${pkgs.nushell}/bin/nu";
    terminal = "xterm-256color";
  };
}
