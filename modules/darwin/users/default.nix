{ pkgs, username, ... }:
{
  users.users.${username} = {
    home = "/Users/${username}";
    shell = "${pkgs.zsh}/bin/zsh";
  };
}
