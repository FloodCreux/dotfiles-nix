# Maintenance Guide

This document describes how to maintain and update this Nix configuration.

## Dependency Update Strategy

### Regular Updates (Monthly)

**First Monday of each month**, update all dependencies:

```bash
# Update all inputs
just update

# Or manually:
nix flake update

# Review changes
git diff flake.lock

# Test the updated configuration
just build

# If successful, apply changes
just switch

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
just build && just switch
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
just check              # Validate configuration
just build              # Test build
```

### 3. Document the Input

Add to README.md under "Technologies Used" section.

## Module Management

### Adding a New Language/Tool

1. Copy the module template:
   ```bash
   cp templates/module-template.nix modules/home-manager/home/TOOLNAME/default.nix
   ```

2. Edit the module with your packages (uses `mkEnableOption`/`mkIf` pattern)

3. Import in `modules/home-manager/home/default.nix`:
   ```nix
   # In the imports list:
   ./TOOLNAME
   ```

4. Enable by default in the same file's `modules` block:
   ```nix
   modules.TOOLNAME.enable = true;
   ```

5. Test:
   ```bash
   just build
   ```

### Disabling a Module

Modules use `mkEnableOption` and can be toggled per machine:

1. To disable globally, set in `modules/home-manager/home/default.nix`:
   ```nix
   modules.TOOLNAME.enable = false;
   ```

2. To disable on a specific machine, set in the machine config (e.g., `machines/work.nix`):
   ```nix
   home-manager.users.${username}.modules.TOOLNAME.enable = false;
   ```

3. Rebuild:
   ```bash
   just switch
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

None. The `permittedInsecurePackages` list in `modules/darwin/nixpkgs/default.nix` is empty.

### Review Process

If insecure packages are added in the future, **quarterly** (every 3 months) review them:

1. Check if still needed
2. Look for migration path to newer versions
3. Document continued need or remove

## Cleanup

### Regular Cleanup (After Updates)

```bash
# Remove old generations (keep last 3)
nix-collect-garbage --delete-older-than 30d

# Or use justfile
just clean

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

- [ ] Configuration still builds: `just build`
- [ ] No security advisories for dependencies

### Monthly

- [ ] Update dependencies: `just update && just switch`
- [ ] Review and clean old generations
- [ ] Check disk usage: `du -sh /nix/store`

### Quarterly

- [ ] Review insecure packages list (if any)
- [ ] Check for deprecated nixpkgs packages
- [ ] Update this maintenance guide
- [ ] Review and update README.md

## Emergency Contacts

- **Nix Discourse**: https://discourse.nixos.org/
- **Home-Manager Issues**: https://github.com/nix-community/home-manager/issues
- **Nix-Darwin Issues**: https://github.com/LnL7/nix-darwin/issues
