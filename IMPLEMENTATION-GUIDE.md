# Machine-Specific Configuration - Implementation Guide

## ✅ Implementation Complete!

The machine-specific configuration system has been successfully implemented. Your Nix config now supports per-machine customization!

## What Was Implemented

### 1. Core Changes

#### `lib/overlays.nix`
- Updated `mkDarwin` function to accept optional `machineConfig` parameter
- Loads machine settings and passes `extraSystemPackages` and `extraHomePackages` to modules

#### `flake.nix`
- Updated `lib.mkDarwinSystem` to accept optional `machineConfig` parameter
- Passes `machineConfig` through to the builder
- Added hostname-based configuration for auto-detection

#### `modules/darwin/default.nix`
- Now accepts `extraSystemPackages` parameter
- Merges machine-specific system packages with core configuration

#### `modules/home-manager/default.nix`
- Now accepts `extraHomePackages` parameter
- Merges machine-specific home packages with core configuration

### 2. Machine Configuration Files

Created two machine configs:
- `machines/personal.nix` - For personal machine (username: mike)
- `machines/work.nix` - For work machine (username: chmc-h022fl97xj)

## How to Use

### Current Setup (No Machine Config)

Your current configuration works exactly as before:

```bash
# Build and switch using username-based configs
darwin-rebuild switch --flake .#mike
darwin-rebuild switch --flake .#chmc-h022fl97xj

# Or use aliases
darwin-rebuild switch --flake .#default  # Uses mike
darwin-rebuild switch --flake .#work     # Uses chmc-h022fl97xj

# Or just let it auto-detect by hostname
darwin-rebuild switch --flake .
```

### Adding Machine-Specific Packages

To add machine-specific packages, edit the appropriate machine config:

#### Example: Add Docker to Work Machine

Edit `machines/work.nix`:

```nix
extraSystemPackages = with pkgs; [
  docker
  kubectl
  awscli2
];
```

Then rebuild:

```bash
darwin-rebuild switch --flake .
```

#### Example: Add GUI Apps to Personal Machine

Edit `machines/personal.nix`:

```nix
extraHomePackages = with pkgs; [
  # Add GUI or user-specific tools
];
```

### Using Machine Configs in Flake

To actually use a machine config, update `flake.nix`:

```nix
darwinConfigurations = {
  # With machine config
  work = mkDarwinSystem {
    username = "chmc-h022fl97xj";
    machineConfig = ./machines/work.nix;  # Add this line
  };

  # Or for personal
  personal = mkDarwinSystem {
    username = "mike";
    machineConfig = ./machines/personal.nix;  # Add this line
  };
};
```

## Example Use Cases

### Use Case 1: Different Tools on Work vs Personal

**Personal Machine** (`machines/personal.nix`):
```nix
extraSystemPackages = with pkgs; [
  docker          # Container development
  ffmpeg          # Media projects
  imagemagick     # Image manipulation
];
```

**Work Machine** (`machines/work.nix`):
```nix
extraSystemPackages = with pkgs; [
  kubectl         # Kubernetes
  terraform       # Infrastructure
  awscli2         # AWS tools
];
```

### Use Case 2: Same User, Multiple Machines

```nix
darwinConfigurations = {
  personal-macbook = mkDarwinSystem {
    username = "mike";
    machineConfig = ./machines/personal.nix;
  };

  personal-mac-mini = mkDarwinSystem {
    username = "mike";
    machineConfig = ./machines/server.nix;  # Different config!
  };
};
```

### Use Case 3: Minimal CI Machine

Create `machines/ci.nix`:

```nix
{ pkgs, username, ... }:
{
  machine = {
    hostname = "ci-server";
    type = "ci";
  };

  # Only essential build tools
  extraSystemPackages = with pkgs; [
    git
    docker
  ];

  # No GUI apps
  extraHomePackages = [ ];
}
```

## Current Configuration Status

Your current setup:
- ✅ Machine config system is **implemented and working**
- ✅ Build successful with `make build`
- ✅ Backwards compatible (works without machine configs)
- ✅ Two machine configs created (personal.nix, work.nix)
- ⚠️ Machine configs are **not yet active** (not referenced in flake.nix)

To activate machine-specific configs:
1. Edit `machines/personal.nix` or `machines/work.nix` to add packages
2. Update `flake.nix` darwinConfigurations to reference machine configs
3. Run `darwin-rebuild switch --flake .`

## Testing Your Changes

1. **Check syntax**:
   ```bash
   make check
   ```

2. **Build without activating**:
   ```bash
   make build
   ```

3. **Build and activate**:
   ```bash
   make switch
   ```

## Files Overview

```
nix/
├── flake.nix                          # Updated with machineConfig support
├── lib/
│   └── overlays.nix                   # Updated mkDarwin function
├── modules/
│   ├── darwin/default.nix             # Accepts extraSystemPackages
│   └── home-manager/default.nix       # Accepts extraHomePackages
├── machines/
│   ├── README.md                      # Documentation
│   ├── example.nix                    # Template
│   ├── personal.nix                   # Personal machine (ready to customize)
│   ├── work.nix                       # Work machine (ready to customize)
│   ├── personal-macbook.nix.example   # Advanced example
│   └── work-macbook.nix.example       # Advanced example
└── templates/
    └── module-template.nix            # Template for new tools
```

## Next Steps

1. **Customize machine configs** (optional):
   - Edit `machines/work.nix` to add work-specific packages
   - Edit `machines/personal.nix` to add personal packages

2. **Activate machine configs** (optional):
   - Update `flake.nix` to reference machine configs
   - See examples in `machines/README.md`

3. **Use module templates**:
   - Use `templates/module-template.nix` when adding new tools

4. **Follow maintenance schedule**:
   - See `MAINTENANCE.md` for update procedures

## Troubleshooting

### Build fails after adding packages

Check package names:
```bash
nix search nixpkgs packagename
```

### Want to see what changed?

```bash
git diff
```

### Need to rollback?

```bash
darwin-rebuild switch --rollback
```

## Questions?

- Machine configs: See `machines/README.md`
- Module templates: See `templates/module-template.nix`
- Maintenance: See `MAINTENANCE.md`
- Advanced examples: See `machines/*.example` files
