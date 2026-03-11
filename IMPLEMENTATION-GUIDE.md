# Machine-Specific Configuration - Implementation Guide

## ✅ Implementation Complete!

The machine-specific configuration system has been successfully implemented. Your Nix config now supports per-machine customization!

## What Was Implemented

### 1. Core Changes

#### `lib/mkDarwin.nix`
- The `mkDarwin` function accepts an optional `machineConfig` parameter
- When provided, appends the machine config as an additional nix-darwin module

#### `flake.nix`
- Updated `lib.mkDarwinSystem` to accept optional `machineConfig` parameter
- Passes `machineConfig` through to the builder
- Added hostname-based configuration for auto-detection

#### `modules/darwin/default.nix`
- Imports all darwin sub-modules (environment, homebrew, nixpkgs, system, users)

#### `modules/home-manager/default.nix`
- Imports home, bat, and git modules
- Language/tool modules under `home/` use `mkEnableOption` for per-machine toggling

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
{ pkgs, username, ... }:
{
  environment.systemPackages = with pkgs; [
    docker
    kubectl
    awscli2
  ];
}
```

Then rebuild:

```bash
darwin-rebuild switch --flake .
```

#### Example: Add Packages to Personal Machine

Edit `machines/personal.nix`:

```nix
{ pkgs, username, ... }:
{
  environment.systemPackages = with pkgs; [
    # Add machine-specific tools
  ];
}
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
{ pkgs, username, ... }:
{
  environment.systemPackages = with pkgs; [
    docker          # Container development
    ffmpeg          # Media projects
    imagemagick     # Image manipulation
  ];
}
```

**Work Machine** (`machines/work.nix`):
```nix
{ pkgs, username, ... }:
{
  environment.systemPackages = with pkgs; [
    kubectl         # Kubernetes
    awscli2         # AWS tools
    k9s             # Kubernetes TUI
  ];
  modules.netskope.enable = true;
}
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

### Use Case 3: Minimal Machine

Create `machines/minimal.nix`:

```nix
{ pkgs, username, ... }:
{
  # Only essential system tools
  environment.systemPackages = with pkgs; [
    docker
  ];

  # Disable dev modules not needed on this machine
  home-manager.users.${username}.modules = {
    scala.enable = false;
    haskell.enable = false;
    ocaml.enable = false;
    elixir.enable = false;
  };
}
```

## Current Configuration Status

Your current setup:
- ✅ Machine config system is **implemented and working**
- ✅ Build successful with `just build`
- ✅ Backwards compatible (works without machine configs)
- ✅ Two machine configs created (personal.nix, work.nix)
- ✅ `work.nix` is **active** in `flake.nix` (used by `work` and hostname-based configurations)
- ⚠️ `personal.nix` is **not yet active** (not referenced in flake.nix)

To activate machine-specific configs:
1. Edit `machines/personal.nix` or `machines/work.nix` to add packages
2. Update `flake.nix` darwinConfigurations to reference machine configs
3. Run `darwin-rebuild switch --flake .`

## Testing Your Changes

1. **Check syntax**:
   ```bash
   just check
   ```

2. **Build without activating**:
   ```bash
   just build
   ```

3. **Build and activate**:
   ```bash
   just switch
   ```

## Files Overview

```
nix/
├── flake.nix                          # Updated with machineConfig support
├── lib/
│   ├── mkDarwin.nix                   # Darwin builder (accepts machineConfig)
│   └── overlays.nix                   # All overlays (Metals, Neovim, Rust, tree-sitter)
├── modules/
│   ├── darwin/default.nix             # Darwin module imports
│   └── home-manager/default.nix       # Home-manager module imports
├── machines/
│   ├── README.md                      # Documentation
│   ├── example.nix                    # Template for new machines
│   ├── personal.nix                   # Personal machine (ready to customize)
│   └── work.nix                       # Work machine (awscli2, k9s, Netskope)
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
