# Work machine configuration for user 'chmc-h022fl97xj'
{ pkgs, username, ... }:
{
  machine = {
    hostname = "work-macbook";
    description = "Work MacBook Pro";
    type = "work";
  };

  # Additional system packages for work machine
  extraSystemPackages = with pkgs; [
    # Example: kubectl, terraform, awscli2, etc.
    kubectl
    awscli2
  ];

  # Additional home packages for work machine
  extraHomePackages = with pkgs; [
    # Add work-specific user packages here
  ];

  # Module overrides (future use)
  modules = { };

  # Machine-specific environment variables
  environment = { };
}
