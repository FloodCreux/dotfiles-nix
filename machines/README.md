# Machine-Specific Configurations

This directory contains machine-specific configuration overrides. Each machine can customize settings without modifying the core flake.

## Structure

```
machines/
├── README.md                    # This file
├── example.nix                  # Example template
├── personal.nix                 # Personal machine config
└── work.nix                     # Work machine config
```

## Usage

### 1. Create a machine configuration file

Machine configs are standard nix-darwin modules. They can set any nix-darwin option
and toggle home-manager modules via `home-manager.users.${username}`.

```nix
# machines/my-machine.nix
{ pkgs, username, ... }:
{
  # Machine-specific system packages
  environment.systemPackages = with pkgs; [
    awscli2
    k9s
  ];

  # Darwin-level module options
  # modules.netskope.enable = true;  # For corporate SSL proxies

  # Toggle dev tool modules (all enabled by default)
  # home-manager.users.${username}.modules.ocaml.enable = false;
  # home-manager.users.${username}.modules.haskell.enable = false;
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
