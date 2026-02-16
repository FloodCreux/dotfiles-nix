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
    awscli2
    k9s
  ];

  # Additional home packages for work machine
  extraHomePackages = with pkgs; [
    # Add work-specific user packages here
  ];

  # Module overrides (future use)
  modules = { };

  # Machine-specific environment variables
  environment = { };

  # Enable Netskope SSL inspection certificate handling
  netskope.enable = true;
}
