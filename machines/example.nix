# Example machine-specific configuration
# Copy this file and customize for your machine

{ pkgs, username, ... }:
{
  # Machine identification
  machine = {
    hostname = "example-machine";
    description = "Example machine configuration";
    type = "personal"; # or "work"
  };

  # Additional system packages for this machine only
  extraSystemPackages = with pkgs; [
    # Add machine-specific CLI tools here
    # Example: docker, kubernetes-cli, etc.
  ];

  # Additional home packages for this machine only
  extraHomePackages = with pkgs; [
    # Add machine-specific GUI apps or user tools here
    # Example: vscode, slack, etc.
  ];

  # Module overrides - enable/disable specific modules
  modules = {
    # Darwin (system-level) module overrides
    darwin = {
      # rust.enable = false;      # Disable Rust on this machine
      # python.enable = true;     # Enable Python on this machine
      # scala.enable = false;     # Disable Scala on this machine
    };

    # Home-manager (user-level) module overrides
    home = {
      # wezterm.enable = false;   # Disable Wezterm terminal
      # ghostty.enable = true;    # Enable Ghostty terminal
    };
  };

  # Machine-specific environment variables
  environment = {
    # WORK_PROJECT_DIR = "/Users/${username}/work";
    # PERSONAL_PROJECT_DIR = "/Users/${username}/personal";
  };

  # Machine-specific system settings
  system = {
    # Override keyboard settings, dock settings, etc.
    # defaults = {
    #   NSGlobalDomain = {
    #     KeyRepeat = 1;
    #   };
    # };
  };

  # Machine-specific Git configuration
  git = {
    # userName = "Work Name";
    # userEmail = "work@example.com";
  };
}
