# Personal machine configuration
{ pkgs, ... }:
{
  # Additional system packages for personal machine
  environment.systemPackages = with pkgs; [
    # Add personal-specific packages here
    # Example: docker, ffmpeg, etc.
  ];

  # Module overrides - disable modules not needed on this machine:
  # modules.ocaml.enable = false;
  # modules.go.enable = false;
}
