# nix-config

> Personal Nix configuration for macOS development environments

[![Flake Check](https://github.com/FloodCreux/nix/actions/workflows/flake.yml/badge.svg)](https://github.com/FloodCreux/nix/actions/workflows/flake.yml)

A declarative, reproducible configuration for macOS development machines using Nix flakes, nix-darwin, and home-manager. Manages system settings and development tools across multiple machines.

## ✨ Features

- 🍎 **macOS-focused**: Optimized for Apple Silicon (`aarch64-darwin`)
- 🏢 **Multi-profile support**: Separate configurations for personal (`mike`) and work (`chmc-h022fl97xj`) machines
- 🛠️ **Multi-language development**: Scala, Rust, Python, Go, OCaml, Haskell, Elixir, Java, C/C++, Node.js (LSP/formatters), Lua, SQL
- 📝 **Modern editor setup**: Neovim nightly with LSP support and custom Metals configuration
- 🔧 **CLI power tools**: ripgrep, fd, jq, bat, tree, tree-sitter, and more
- 🔌 **Toggleable modules**: Enable/disable any language or tool per machine
- 🎨 **Consistent theming**: Catppuccin Macchiato across tools

## 📋 Prerequisites

- **macOS** (Apple Silicon preferred)
- **Nix** with flakes enabled (>= 2.18)
- **nix-darwin** for system configuration
- **Git** for cloning this repository

## 🚀 Quick Start

### First-Time Installation

1. **Install Nix** (if not already installed):

```bash
curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install
```

2. **Clone this repository**:

```bash
git clone https://github.com/FloodCreux/nix.git ~/.config/nix
cd ~/.config/nix
```

3. **Build and activate** (choose your profile):

For personal machines:

```bash
nix build .#darwinConfigurations.default.system
./result/sw/bin/darwin-rebuild switch --flake .#default
```

For work machines:

```bash
nix build .#darwinConfigurations.work.system
./result/sw/bin/darwin-rebuild switch --flake .#work
```

4. **Restart your terminal** to apply all shell configurations.

### Applying Changes

After modifying any `.nix` files:

```bash
darwin-rebuild switch --flake ~/.config/nix#default  # or #work
```

### Updating Dependencies

Update all flake inputs:

```bash
nix flake update
darwin-rebuild switch --flake ~/.config/nix#default
```

Update specific inputs:

```bash
nix flake lock --update-input nixpkgs
nix flake lock --update-input home-manager
```

## 📁 Repository Structure

```
.
├── flake.nix                 # Main flake configuration
├── flake.lock               # Locked dependency versions
├── Makefile / justfile      # Build automation (check, build, switch, update, etc.)
├── lib/                     # Custom library functions
│   ├── default.nix         # Exports mkDarwin and overlays
│   ├── mkDarwin.nix        # Darwin system builder function
│   ├── metalsBuilder.nix   # Custom Metals LSP builder
│   ├── metalsOverlay.nix   # Metals overlay
│   └── overlays.nix        # All overlays (Neovim, Rust, Metals, tree-sitter)
├── machines/                # Machine-specific configuration overrides
│   ├── example.nix         # Template for new machines
│   ├── personal.nix        # Personal machine config
│   └── work.nix            # Work machine config (awscli2, k9s, Netskope)
├── modules/
│   ├── darwin/             # nix-darwin system configuration
│   │   ├── default.nix    # Main darwin module imports
│   │   ├── environment/   # System environment variables, Netskope SSL handling
│   │   ├── homebrew/      # Homebrew integration
│   │   ├── nixpkgs/       # nixpkgs config (allowUnfree)
│   │   ├── system/        # macOS system defaults (Finder, Dock, keyboard, etc.)
│   │   └── users/         # User account configuration
│   ├── home-manager/       # home-manager user configuration
│   │   ├── default.nix    # Imports home, bat, git
│   │   ├── bat/           # Bat configuration
│   │   ├── git/           # Git + delta configuration
│   │   └── home/          # User-level packages and configs
│   │       ├── default.nix    # Imports all modules, Catppuccin theming
│   │       ├── core/          # Core CLI tools (always installed)
│   │       └── <lang>/        # Toggleable language/tool modules
│   └── shared/             # Shared between darwin and home-manager
│       └── nix.nix        # Nix daemon settings
├── scripts/
│   └── netskope_cert.sh   # Netskope SSL cert bootstrap script
└── templates/
    └── module-template.nix # Template for creating new modules
```

## 🏗️ Configurations

### `default` - Personal Configuration

- **Username**: `mike`
- **Focus**: General development and personal projects
- **Includes**: All language toolchains, personal dotfiles

### `work` - Work Configuration

- **Username**: `chmc-h022fl97xj`
- **Focus**: Professional development with additional enterprise tools
- **Includes**: All `default` features plus machine-specific packages
- **Extra**: awscli2, k9s, Netskope SSL certificate handling

## 🛠️ Managed Components

### Languages & Runtimes

All language modules are toggleable per machine via `modules.<name>.enable`.

- **Scala**: sbt, coursier, Metals LSP (custom overlay), maven, scalafmt
- **Rust**: Complete toolchain via fenix overlay (cargo, clippy, rustc, rustfmt, rust-src)
- **Python**: pipx (runtimes managed externally)
- **Go**: Go toolchain
- **OCaml**: ocaml, opam, dune, ocamlformat, LSP
- **Haskell**: GHC, Cabal, zlib
- **Elixir**: Elixir, elixir-ls
- **Java**: OpenJDK 8, 11, 17, 21 (combined buildEnv, JAVA_HOME set to JDK 21)
- **C/C++**: cmake
- **Node.js**: JSON language server, prettier (runtime managed externally)
- **Lua**: Lua, stylua
- **SQL**: SQLite

### Development Tools

- **Editor**: Neovim nightly with tree-sitter grammars (24 languages)
- **Version Control**: Git (with delta), gh CLI
- **Databases**: SQLite

### Core CLI Utilities

Always-installed tools (in `modules/home-manager/home/core/`):

- **Search**: ripgrep, fd
- **File Tools**: bat (via home-manager program), tree, jq
- **Misc**: curl, less, coreutils, tree-sitter, chafa, nixfmt

### Additional Tools

- **File Manager**: yazi (toggleable module)
- **Hadoop**: Hadoop tools (toggleable module)
- **Nix LSP**: nixd, nil (toggleable module)

## 🔧 Customization

### Adding a New Package

1. **System-wide** (available to all users):

```nix
# In modules/darwin/environment/default.nix
environment.systemPackages = with pkgs; [
  your-package
];
```

2. **User-specific** (home-manager):

```nix
# In modules/home-manager/home/<category>/default.nix
home.packages = with pkgs; [
  your-package
];
```

### Adding a New Module

1. Copy the template: `cp templates/module-template.nix modules/home-manager/home/your-tool/default.nix`
2. Edit the module with your packages and `mkEnableOption`/`mkIf` pattern
3. Import it in `modules/home-manager/home/default.nix`
4. Add `modules.your-tool.enable = true;` in the same file's `modules` block

## 🐛 Troubleshooting

### Build Failures

Check the flake:

```bash
nix flake check
```

Check for syntax errors:

```bash
nix flake show
```

View detailed build logs:

```bash
darwin-rebuild switch --flake .#default --show-trace
```

### Homebrew Issues

If Homebrew packages aren't installing:

```bash
# Manually trigger Homebrew bundle
brew bundle --file=/opt/homebrew/Brewfile
```

### Neovim LSP Issues

If Metals or other LSPs aren't working:

1. Check Neovim health: `:checkhealth`
2. Metals is managed via a custom overlay in `lib/metalsOverlay.nix` -- update the version there
3. Rebuild and restart Neovim

## 🔄 CI/CD

This repository uses GitHub Actions to validate the flake configuration:

- **Workflow**: `.github/workflows/flake.yml`
- **Triggers**: Pull requests and pushes to `main`
- **Checks**: `nix flake check` to ensure configuration builds

**Note**: CI runs on Ubuntu, but the flake targets `aarch64-darwin`. The check validates syntax and structure but cannot fully test Darwin-specific features.

## 📚 Key Technologies

- **[Nix](https://nixos.org/)**: Declarative package management
- **[nix-darwin](https://github.com/LnL7/nix-darwin)**: Nix modules for macOS system configuration
- **[home-manager](https://github.com/nix-community/home-manager)**: User environment management
- **[flake-parts](https://flake.parts/)**: Simplified flake structure
- **[fenix](https://github.com/nix-community/fenix)**: Rust toolchain overlay
- **[neovim-nightly-overlay](https://github.com/nix-community/neovim-nightly-overlay)**: Latest Neovim builds

## 📖 Resources

- [Nix Manual](https://nixos.org/manual/nix/stable/)
- [nix-darwin Manual](https://daiderd.com/nix-darwin/manual/)
- [home-manager Manual](https://nix-community.github.io/home-manager/)
- [Nix Flakes Wiki](https://nixos.wiki/wiki/Flakes)

## 🤝 Contributing

This is a personal configuration, but feel free to:

- Fork and adapt for your own use
- Submit issues for bugs or questions
- Suggest improvements via pull requests

## 📜 License

Personal use. Feel free to use as inspiration for your own configurations.

## 🙏 Acknowledgments

Built with inspiration from the Nix community and various dotfiles repositories.

---

**Maintained by**: Mike Flood
**Mirrors**: [GitHub](https://github.com/FloodCreux/nix) | [Codeberg](https://codeberg.org/flood-mike/nix)
