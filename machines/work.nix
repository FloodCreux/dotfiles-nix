# Work machine configuration
{ pkgs, username, ... }:
{
  # Machine-specific system packages (not general dev tools)
  environment.systemPackages = with pkgs; [
    awscli2
    k9s
  ];

  # Enable Netskope SSL inspection certificate handling (darwin-level)
  modules.netskope.enable = true;

  # Module overrides — disable dev tool modules not needed on this machine:
  # home-manager.users.${username}.modules.ocaml.enable = false;
  # home-manager.users.${username}.modules.go.enable = false;
}
