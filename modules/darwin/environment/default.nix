{ pkgs, ... }:
{
  environment = {
    shells = with pkgs; [
      nushell
    ];

    systemPackages = [
      pkgs.coreutils
    ];

    systemPath = [ "/opt/homebrew/bin" ];
    pathsToLink = [ "/Applications" ];

    variables = {
      XDG_CONFIG_HOME = "$HOME/.config";
      SHELL = "${pkgs.zsh}/bin/zsh";
    };
  };
}
