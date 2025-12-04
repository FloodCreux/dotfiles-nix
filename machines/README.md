# Machine-Specific Configurations

This directory contains machine-specific configuration overrides. Each machine can customize settings without modifying the core flake.

## Structure

```
machines/
├── README.md                    # This file
├── example.nix                  # Example template
├── personal-macbook.nix         # Personal MacBook Pro
└── work-macbook.nix             # Work MacBook
```

## Usage

### 1. Create a machine configuration file

```nix
# machines/my-machine.nix
{ username, ... }:
{
  # Machine metadata
  machine = {
    hostname = "my-machine";
    description = "My personal MacBook Pro";
  };

  # Override system packages
  extraSystemPackages = with pkgs; [
    # Add machine-specific packages here
  ];

  # Override home-manager packages
  extraHomePackages = with pkgs; [
    # Add machine-specific home packages here
  ];

  # Enable/disable modules
  modules = {
    darwin = {
      # Override darwin modules
      rust.enable = true;
      scala.enable = false;  # Disable on this machine
    };
    home = {
      # Override home-manager modules
      wezterm.enable = false;
    };
  };

  # Machine-specific environment variables
  environment = {
    CUSTOM_VAR = "value";
  };
}
```

### 2. Reference in flake.nix

```nix
darwinConfigurations = {
  my-machine = mkDarwinSystem {
    username = "mike";
    machineConfig = ./machines/my-machine.nix;
  };
};
```

### 3. Build for specific machine

```bash
darwin-rebuild switch --flake .#my-machine
```

## Benefits

- **Separation of concerns**: Machine-specific settings don't pollute the core configuration
- **Easy machine onboarding**: Copy a template, customize, and deploy
- **Profile flexibility**: Same username, different machine configs
- **Clean git history**: Machine changes don't touch core modules
