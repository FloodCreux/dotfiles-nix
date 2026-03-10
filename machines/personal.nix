# Personal machine configuration
{ pkgs, username, ... }:
{
  # Machine-specific system packages
  environment.systemPackages = with pkgs; [
    # Add personal-specific packages here
    # Example: docker, ffmpeg, etc.
  ];

  # Module overrides — disable dev tool modules not needed on this machine:
  # home-manager.users.${username}.modules.ocaml.enable = false;
  # home-manager.users.${username}.modules.go.enable = false;
}
