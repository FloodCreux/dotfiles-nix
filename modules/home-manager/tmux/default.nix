{ pkgs, ... }:
{
  programs.tmux = {
    enable = true;
    shell = "${pkgs.nushell}/bin/nu";
    terminal = "xterm-256color";
  };
}
