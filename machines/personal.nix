# Personal machine configuration for user 'mike'
{ pkgs, username, ... }:
{
  machine = {
    hostname = "personal-macbook";
    description = "Personal MacBook Pro";
    type = "personal";
  };

  # Additional system packages for personal machine
  extraSystemPackages = with pkgs; [
    # Add personal-specific packages here
    # Example: docker, ffmpeg, etc.
  ];

  # Additional home packages for personal machine
  extraHomePackages = with pkgs; [
    # Add personal-specific user packages here
    # Example: GUI apps, etc.
  ];

  # Module overrides (future use)
  modules = { };

  # Machine-specific environment variables
  environment = { };
}
