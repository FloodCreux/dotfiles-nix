# Scalability & Maintainability Improvements

This document outlines the enhanced scalability and maintainability structure for this Nix configuration.

## Overview

The improved structure provides:

1. **Machine-specific configurations** - Different settings per machine, not just per user
2. **Module templates** - Standardized way to add new tools/languages
3. **Documented maintenance strategy** - Clear update and maintenance procedures

## Directory Structure

```
nix/
├── machines/                    # NEW: Machine-specific configs
│   ├── README.md               # Documentation
│   ├── example.nix             # Template
│   ├── personal-macbook.nix    # Personal machine config
│   └── work-macbook.nix        # Work machine config
│
├── templates/                   # NEW: Module templates
│   └── module-template.nix     # Template for new modules
│
├── MAINTENANCE.md              # NEW: Maintenance procedures
├── flake-with-machines.nix.example  # Example flake with machine support
└── [existing files...]
```

## Problem Solved

### Before (Current State)

```nix
# flake.nix
users = ["mike", "chmc-h022fl97xj"];
```

**Issues:**
- ❌ Same config for all machines with same username
- ❌ Can't have different tools on personal vs work machine
- ❌ Hard to add machine-specific overrides
- ❌ No clear pattern for adding new tools
- ❌ Undocumented update strategy

### After (Improved State)

```nix
# flake.nix
darwinConfigurations = {
  personal-macbook = mkDarwinSystem {
    username = "mike";
    machineConfig = ./machines/personal-macbook.nix;
  };

  work-laptop = mkDarwinSystem {
    username = "mike";  # Same user, different config!
    machineConfig = ./machines/work-laptop.nix;
  };
};
```

**Benefits:**
- ✅ Each machine has custom config
- ✅ Personal machine: all tools enabled
- ✅ Work machine: only required tools
- ✅ Clean separation of concerns
- ✅ Easy to onboard new machines
- ✅ Clear maintenance procedures

## Implementation Guide

### Phase 1: Add Machine Support (Optional)

If you want machine-specific configs:

1. **Review the example flake:**
   ```bash
   cat flake-with-machines.nix.example
   ```

2. **Create machine configs:**
   ```bash
   # Copy examples and customize
   cp machines/personal-macbook.nix.example machines/personal-macbook.nix
   cp machines/work-macbook.nix.example machines/work-macbook.nix
   ```

3. **Update flake.nix:**
   - Add `machineConfig` parameter to `mkDarwinSystem`
   - Update `darwinConfigurations` to use machine configs
   - See `flake-with-machines.nix.example` for reference

4. **Update lib/default.nix:**
   - Add support for `extraSystemPackages` and `extraHomePackages`
   - Merge machine settings into module system

5. **Test:**
   ```bash
   make build
   darwin-rebuild switch --flake .#machine-name
   ```

### Phase 2: Use Module Templates

When adding a new tool:

1. **Copy template:**
   ```bash
   cp templates/module-template.nix modules/darwin/newtool/default.nix
   ```

2. **Edit module:**
   - Add packages
   - Add configuration
   - Follow comments in template

3. **Import module:**
   ```nix
   # In modules/darwin/default.nix
   ./newtool
   ```

4. **Test:**
   ```bash
   make build
   ```

### Phase 3: Follow Maintenance Procedures

See `MAINTENANCE.md` for:
- Monthly update schedule
- Dependency update strategy
- Rollback procedures
- Health check checklists

## Real-World Examples

### Example 1: Same User, Different Machines

```nix
# Personal MacBook: All development tools
personal-macbook = mkDarwinSystem {
  username = "mike";
  machineConfig = ./machines/personal-macbook.nix;
};
# Enables: Rust, Scala, Go, Python, Zig, OCaml, Docker, Godot

# Work MacBook: Only required tools
work-macbook = mkDarwinSystem {
  username = "mike";
  machineConfig = ./machines/work-macbook.nix;
};
# Enables: Scala, Python, Go, AWS CLI, Kubernetes
# Disables: Rust, Zig, OCaml, personal tools
```

### Example 2: Work Profile with Different Git Configs

```nix
# machines/work-macbook.nix
git = {
  userName = "Mike Flood";
  userEmail = "mike@company.com";  # Work email
  signing.key = "WORK_GPG_KEY";
};

environment = {
  WORK_PROJECTS = "/Users/mike/work";
  AWS_PROFILE = "company";
};
```

### Example 3: Minimal Server Config

```nix
# machines/minimal-server.nix
{
  machine = {
    hostname = "build-server";
    type = "ci";
  };

  # Only CI/CD tools, no GUI apps
  extraSystemPackages = with pkgs; [
    git
    docker
    nodejs
  ];

  modules = {
    darwin = {
      rust.enable = true;  # For builds
      scala.enable = false;
      python.enable = true;
    };
  };
}
```

## Migration Path

You don't have to implement everything at once. Here's a gradual approach:

### Step 1: Add Templates (5 minutes)
- Templates already created in `templates/`
- Use immediately when adding new tools

### Step 2: Add Maintenance Docs (0 minutes)
- `MAINTENANCE.md` already created
- Start following monthly update schedule

### Step 3: Add Machine Configs (Optional, 30 minutes)
- Only if you need machine-specific differences
- Can be done incrementally:
  - Week 1: Add machine config structure
  - Week 2: Migrate personal machine
  - Week 3: Migrate work machine
  - Week 4: Test and refine

### Step 4: Gradual Module Migration (Ongoing)
- As you edit modules, gradually adopt template pattern
- No need to migrate everything at once

## Benefits Summary

### Scalability
- ✅ Add new machines in 5 minutes (copy template)
- ✅ Per-machine customization without core changes
- ✅ Same username across multiple machines with different configs
- ✅ Easy to manage 5+ machines

### Maintainability
- ✅ Clear module template reduces copy-paste errors
- ✅ Documented update strategy prevents staleness
- ✅ Machine configs separated from core logic
- ✅ Easy to debug (machine vs core vs module issues)

### Developer Experience
- ✅ New team members can fork and customize easily
- ✅ Clear patterns for common tasks
- ✅ Self-documenting structure
- ✅ Rollback procedures documented

## Next Steps

1. **Immediate (Use now):**
   - Use `templates/module-template.nix` for new modules
   - Follow `MAINTENANCE.md` for updates
   - Reference `machines/README.md` when needed

2. **Short term (If needed):**
   - Implement machine-specific configs
   - Migrate current configs to new structure

3. **Long term (Continuous):**
   - Follow monthly maintenance schedule
   - Update templates based on learnings
   - Document machine-specific quirks

## Questions?

- Module templates: See `templates/module-template.nix`
- Machine configs: See `machines/README.md`
- Maintenance: See `MAINTENANCE.md`
- Example implementation: See `flake-with-machines.nix.example`
