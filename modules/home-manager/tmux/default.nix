{ pkgs, ... }:
{
  programs.tmux = {
    enable = true;
    extraConfig = builtins.readFile ./tmux.conf;
    shell = "${pkgs.nushell}/bin/nu";
    # shell = "${pkgs.zsh}/bin/zsh";
    terminal = "xterm-256color";
  };
}
