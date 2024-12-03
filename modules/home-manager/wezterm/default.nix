{ username, ... }:
{
  programs.wezterm = {
    enable = true;
    extraConfig = builtins.replaceStrings [ "$NIX_HOME" ] [ "/etc/profiles/per-user/${username}" ] (
      builtins.readFile ./wezterm.lua
    );
  };
}
