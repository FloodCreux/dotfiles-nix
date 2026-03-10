# Work machine configuration
{ pkgs, ... }:
{
  # Additional system packages for work machine
  environment.systemPackages = with pkgs; [
    awscli2
    k9s
  ];

  # Enable Netskope SSL inspection certificate handling
  modules.netskope.enable = true;

  # Module overrides - disable modules not needed on this machine:
  # modules.ocaml.enable = false;
  # modules.go.enable = false;
}
