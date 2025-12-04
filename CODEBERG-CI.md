# Codeberg CI/CD Setup Guide

This repository includes CI/CD configurations for Codeberg. You have two options:

## Option 1: Woodpecker CI (Recommended)

**Status:** ✅ Stable, production-ready
**Hosted:** Yes, by Codeberg
**Setup:** Simple, just enable in repository settings

### Why Woodpecker?

- Officially recommended by Codeberg
- Hosted service (no self-hosting required)
- Stable and mature
- Simple YAML syntax
- Fast setup

### Setup Instructions

1. **Enable Woodpecker CI:**
   - Go to your repository on Codeberg
   - Settings → Integrations
   - Enable "Woodpecker CI"

2. **Configuration file:** `.woodpecker.yml` (already created)

3. **Test it:**
   - Push to main branch or create a pull request
   - Check the "CI/CD" tab in your repository

### Woodpecker Configuration

```yaml
# .woodpecker.yml
when:
  - event: [push, pull_request]
    branch: main

steps:
  format-check:
    image: nixos/nix:latest
    commands:
      - nix-shell -p nixfmt --run "nixfmt --check **/*.nix"
```

**Documentation:** https://docs.codeberg.org/ci/woodpecker/

---

## Option 2: Forgejo Actions (GitHub Actions-like)

**Status:** ⚠️ Open Beta (self-hosted runners recommended)
**Hosted:** Limited (use self-hosted runner)
**Setup:** More complex, requires runner setup

### Why Forgejo Actions?

- Familiar syntax (similar to GitHub Actions)
- Reusable workflows from GitHub
- Growing ecosystem
- Good for migration from GitHub

### Setup Instructions

#### For Self-Hosted Runner:

1. **Set up a Forgejo Runner:**
   - Follow guide: https://docs.codeberg.org/ci/actions/
   - Install runner on your machine or server
   - Register with Codeberg

2. **Configuration file:** `.forgejo/workflows/flake.yml` (already created)

3. **Test it:**
   - Push to repository
   - Check Actions tab on Codeberg

#### For Hosted Runner (Limited Beta):

Currently in limited availability. Self-hosted runners recommended.

### Forgejo Actions Configuration

```yaml
# .forgejo/workflows/flake.yml
name: "flake"

on:
  push:
    branches: [main]

jobs:
  check:
    runs-on: ubuntu-latest
    steps:
      - uses: https://code.forgejo.org/actions/checkout@v4
      - run: nix flake check
```

**Documentation:** https://forgejo.org/docs/latest/user/actions/

---

## Comparison Table

| Feature | Woodpecker CI | Forgejo Actions |
|---------|---------------|-----------------|
| **Stability** | ✅ Production-ready | ⚠️ Open Beta |
| **Hosted** | ✅ Yes, by Codeberg | ⚠️ Limited / Self-hosted |
| **Setup Complexity** | ✅ Simple | ⚠️ Complex (self-hosted) |
| **Syntax** | Simple YAML | GitHub Actions-like |
| **Ecosystem** | Mature | Growing |
| **Documentation** | Comprehensive | Good |
| **Maintenance** | ✅ Low | Medium (if self-hosted) |

---

## Current Configuration

Both CI configurations are included in this repository:

```
nix/
├── .woodpecker.yml                    # Woodpecker CI (recommended)
├── .forgejo/workflows/flake.yml       # Forgejo Actions
└── .github/workflows/flake.yml        # GitHub Actions (for comparison)
```

All three run the same checks:
1. ✅ Check Nix formatting (`nixfmt --check`)
2. ✅ Validate flake syntax (`nix flake check`)
3. ✅ Show flake info

---

## Recommendation

**For most users:** Use **Woodpecker CI**

- ✅ Simpler setup (just enable in settings)
- ✅ Hosted by Codeberg (no self-hosting)
- ✅ Stable and production-ready
- ✅ Lower maintenance

**Use Forgejo Actions if:**
- You're migrating from GitHub Actions
- You want GitHub Actions syntax compatibility
- You can self-host a runner
- You want to reuse existing GitHub Actions workflows

---

## Migration from GitHub

### From GitHub Actions → Woodpecker CI

1. Copy workflow steps to `.woodpecker.yml`
2. Adjust syntax (simpler, no `uses:` for actions)
3. Enable Woodpecker in Codeberg settings

### From GitHub Actions → Forgejo Actions

1. Copy `.github/workflows/` to `.forgejo/workflows/`
2. Change checkout action to v4:
   ```yaml
   uses: https://code.forgejo.org/actions/checkout@v4
   ```
3. Set up self-hosted runner
4. Test workflow

---

## Testing Locally

### Woodpecker CI

Use Woodpecker CLI to test locally:

```bash
# Install Woodpecker CLI
nix-shell -p woodpecker-cli

# Test configuration
woodpecker exec .woodpecker.yml
```

### Forgejo Actions

Use `act` to test locally:

```bash
# Install act
nix-shell -p act

# Test workflow
act -W .forgejo/workflows/flake.yml
```

---

## Troubleshooting

### Woodpecker CI

**Issue:** Pipeline not running
**Solution:** Check repository settings → Integrations → Ensure Woodpecker is enabled

**Issue:** Nix commands fail
**Solution:** Use `nixos/nix:latest` image with experimental features:
```yaml
commands:
  - nix --extra-experimental-features "nix-command flakes" flake check
```

### Forgejo Actions

**Issue:** Checkout fails
**Solution:** Use checkout@v4, not v6 (v6 has compatibility issues)

**Issue:** Runner not picking up jobs
**Solution:** Check runner registration and ensure it's connected to Codeberg

---

## Resources

### Official Documentation

- **Codeberg CI Overview:** https://docs.codeberg.org/ci/
- **Woodpecker CI:** https://docs.codeberg.org/ci/woodpecker/
- **Forgejo Actions:** https://docs.codeberg.org/ci/actions/
- **Forgejo Actions Reference:** https://forgejo.org/docs/latest/user/actions/reference/
- **GitHub Actions Compatibility:** https://forgejo.org/docs/latest/user/actions/github-actions/

### Community

- **Codeberg Actions Discussion:** https://codeberg.org/actions/meta
- **Forgejo Forum:** https://forgejo.org/docs/latest/user/

---

## Next Steps

1. **Choose your CI solution:**
   - Woodpecker CI (recommended for simplicity)
   - Forgejo Actions (for GitHub Actions familiarity)

2. **Enable in Codeberg:**
   - Go to repository settings
   - Enable chosen CI system

3. **Test:**
   - Push a commit
   - Check CI/CD tab for results

4. **Iterate:**
   - Add more checks as needed
   - Optimize build times
   - Add deployment steps
