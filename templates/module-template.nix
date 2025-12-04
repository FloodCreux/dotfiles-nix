# Template for creating new tool/language modules
#
# Usage:
#   1. Copy this file to modules/darwin/TOOLNAME/default.nix or modules/home-manager/TOOLNAME/default.nix
#   2. Replace TOOLNAME with your tool name
#   3. Add packages and configuration
#   4. Import in modules/darwin/default.nix or modules/home-manager/default.nix
#
# Example locations:
#   - System tools: modules/darwin/TOOLNAME/default.nix
#   - User tools: modules/home-manager/TOOLNAME/default.nix
#   - Language packages: modules/home-manager/home/LANGUAGE/default.nix

{ pkgs, ... }:
{
  # For darwin (system-level) modules:
  # Install system-wide packages
  environment.systemPackages = with pkgs; [
    # Add your packages here
    # Example: rust-analyzer, cargo, rustc
  ];

  # For home-manager (user-level) modules:
  # Install user packages
  # home.packages = with pkgs; [
  #   # Add your packages here
  # ];

  # Optional: Add environment variables
  # environment.variables = {
  #   TOOL_HOME = "${pkgs.TOOLNAME}";
  # };

  # Optional: Add shell aliases
  # programs.zsh.shellAliases = {
  #   tool = "command";
  # };

  # Optional: Add configuration files
  # home.file.".toolrc".text = ''
  #   # Tool configuration
  #   setting = value
  # '';

  # Optional: Enable and configure programs managed by home-manager
  # programs.TOOL = {
  #   enable = true;
  #   # Add program-specific configuration
  # };
}

# Documentation checklist:
# [ ] Added to appropriate default.nix imports
# [ ] Tested with `make build`
# [ ] Verified packages install correctly
# [ ] Documented any special configuration needed
# [ ] Updated README.md if this is a major feature
