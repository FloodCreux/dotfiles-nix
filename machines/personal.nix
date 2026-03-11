# Personal machine configuration
{ username, ... }:
{
  # Disable dev tool modules not needed on this machine
  home-manager.users.${username}.modules = {
    hadoop.enable = false;
    scala.enable = false;
  };
}
