# Maintenance Guide

This document describes how to maintain and update this Nix configuration.

## Dependency Update Strategy

### Regular Updates (Monthly)

**First Monday of each month**, update all dependencies:

```bash
# Update all inputs
make update

# Or manually:
nix flake update

# Review changes
git diff flake.lock

# Test the updated configuration
make build

# If successful, apply changes
make switch

# Commit the updates
git add flake.lock
git commit -m "chore: Update flake inputs (YYYY-MM)"
```

### Selective Updates

Update specific inputs when needed:

```bash
# Update only nixpkgs
nix flake lock --update-input nixpkgs

# Update only home-manager
nix flake lock --update-input home-manager

# Update only rust toolchain (fenix)
nix flake lock --update-input fenix
```

### Security Updates

If a security vulnerability is announced:

1. Check if it affects any of our dependencies
2. Update immediately (don't wait for monthly cycle)
3. Test thoroughly before deploying

```bash
# Emergency security update
nix flake update
make build && make switch
```

## Dependency Channels

### Current Channel Strategy

- **nixpkgs**: `nixos-unstable` - Rolling release, latest packages
- **home-manager**: `master` - Tracks nixpkgs unstable
- **fenix**: `monthly` - Rust toolchain, updated monthly
- **neovim**: `nightly` - Latest Neovim features

### Why These Channels?

- **unstable**: Provides latest packages for development tools
- **monthly** (fenix): Balance between stability and updates
- **nightly** (neovim): IDE setup requires latest features

### Rollback Strategy

If an update breaks something:

```bash
# Rollback to previous generation
darwin-rebuild switch --rollback

# Or specify a generation
darwin-rebuild switch --switch-generation 123

# List available generations
darwin-rebuild --list-generations
```

## Adding New Dependencies

### 1. Flake Inputs

```nix
# In flake.nix inputs section:
new-input = {
  url = "github:owner/repo";
  inputs.nixpkgs.follows = "nixpkgs";  # Reuse our nixpkgs
};
```

### 2. Test Before Committing

```bash
nix flake lock          # Generate lock file entry
make check              # Validate configuration
make build              # Test build
```

### 3. Document the Input

Add to README.md under "Technologies Used" section.

## Module Management

### Adding a New Language/Tool

1. Copy the module template:
   ```bash
   cp templates/module-template.nix modules/darwin/TOOLNAME/default.nix
   ```

2. Edit the module with your packages

3. Import in the appropriate default.nix:
   ```nix
   # In modules/darwin/default.nix or modules/home-manager/default.nix
   ./TOOLNAME
   ```

4. Test:
   ```bash
   make build
   ```

### Disabling a Module

1. Comment out the import in default.nix:
   ```nix
   # ./TOOLNAME  # Disabled: reason
   ```

2. Rebuild:
   ```bash
   make switch
   ```

### Removing a Module

1. Delete the module directory
2. Remove the import from default.nix
3. Clean up any related overlay code in lib/overlays.nix
4. Rebuild and test

## Machine-Specific Configuration

### Adding a New Machine

1. Copy the example machine config:
   ```bash
   cp machines/example.nix machines/NEW-MACHINE.nix
   ```

2. Customize the configuration

3. Add to flake.nix darwinConfigurations:
   ```nix
   darwinConfigurations = {
     NEW-MACHINE = mkDarwinSystem {
       username = "username";
       machineConfig = ./machines/NEW-MACHINE.nix;
     };
   };
   ```

4. Deploy:
   ```bash
   darwin-rebuild switch --flake .#NEW-MACHINE
   ```

## Insecure Packages

### Current Insecure Packages Permitted

- `dotnet-sdk-6.0.428` and related .NET 6 packages

### Why?

.NET 6 reached end-of-life but some legacy projects still require it. This is documented in `flake.nix:47-53`.

### Review Process

**Quarterly** (every 3 months), review insecure packages:

1. Check if still needed
2. Look for migration path to newer versions
3. Document continued need or remove

## Cleanup

### Regular Cleanup (After Updates)

```bash
# Remove old generations (keep last 3)
nix-collect-garbage --delete-older-than 30d

# Or use Makefile
make clean

# Check disk usage
du -sh /nix/store
```

## Troubleshooting Common Update Issues

### Build Fails After Update

1. Check flake.lock diff to see what changed
2. Rollback the problematic input:
   ```bash
   git restore flake.lock
   nix flake lock --update-input OTHER-INPUT
   ```

3. Report issue to upstream repository

### Incompatible Overlays

If overlays break after nixpkgs update:

1. Check lib/overlays.nix
2. Review upstream package changes
3. Update overlay logic to match new package structure

### Home-Manager Conflicts

If home-manager complains about conflicts:

1. Check modules/home-manager/ for duplicate settings
2. Review home-manager changelog for breaking changes
3. Update configuration syntax if needed

## Health Checks

### Weekly

- [ ] Configuration still builds: `make build`
- [ ] No security advisories for dependencies

### Monthly

- [ ] Update dependencies: `make update && make switch`
- [ ] Review and clean old generations
- [ ] Check disk usage: `du -sh /nix/store`

### Quarterly

- [ ] Review insecure packages list
- [ ] Check for deprecated nixpkgs packages
- [ ] Update this maintenance guide
- [ ] Review and update README.md

## Emergency Contacts

- **Nix Discourse**: https://discourse.nixos.org/
- **Home-Manager Issues**: https://github.com/nix-community/home-manager/issues
- **Nix-Darwin Issues**: https://github.com/LnL7/nix-darwin/issues
