# nix-config

> Personal Nix configuration for macOS development environments

[![Flake Check](https://github.com/FloodCreux/nix/actions/workflows/flake.yml/badge.svg)](https://github.com/FloodCreux/nix/actions/workflows/flake.yml)

A declarative, reproducible configuration for macOS development machines using Nix flakes, nix-darwin, and home-manager. Manages system settings, development tools, shell configurations, and dotfiles across multiple machines.

## ✨ Features

- 🍎 **macOS-focused**: Optimized for Apple Silicon (`aarch64-darwin`)
- 🏢 **Multi-profile support**: Separate configurations for personal (`mike`) and work (`chmc-h022fl97xj`) machines
- 🛠️ **Multi-language development**: Scala, Rust, Zig, Python, Go, OCaml, Haskell, C#, Java, Node.js, Lua, SQL
- 📝 **Modern editor setup**: Neovim nightly with LSP support and custom Metals configuration
- 🐚 **Enhanced shells**: Zsh with Oh My Posh, Nushell with custom configs
- 🖥️ **Terminal emulators**: Ghostty and Alacritty configurations
- 🪟 **Window management**: Aerospace, Yabai/SKHD dotfiles
- 🔧 **CLI power tools**: ripgrep, fd, fzf, eza, bat, yazi, zoxide, lazygit
- 📦 **Containerization**: Docker/Podman support
- 🔐 **Secrets management**: password-store integration
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
├── lib/                     # Custom library functions
│   ├── default.nix         # Helper functions
│   ├── metalsBuilder.nix   # Custom Metals LSP builder
│   ├── metalsOverlay.nix   # Metals overlay
│   └── overlays.nix        # All overlays (Neovim, Rust, Zig, etc.)
├── modules/
│   ├── darwin/             # nix-darwin system configuration
│   │   ├── default.nix    # Main darwin module imports
│   │   ├── environment/   # System environment variables
│   │   ├── fonts/         # System fonts (JetBrains Mono Nerd Font)
│   │   ├── homebrew/      # Homebrew casks and formulae
│   │   ├── system/        # macOS system defaults (Finder, Dock, etc.)
│   │   ├── users/         # User account configuration
│   │   └── */             # Individual tool modules (nvim, rust, scala, etc.)
│   ├── home-manager/       # home-manager user configuration
│   │   ├── default.nix    # Main home-manager imports
│   │   ├── home/          # User-level packages and configs
│   │   │   ├── default.nix         # Home configuration
│   │   │   ├── dotfiles/           # Managed dotfiles
│   │   │   └── */                  # Language/tool-specific configs
│   │   └── */             # Shell configs (zsh, nushell, tmux, etc.)
│   └── shared/             # Shared between darwin and home-manager
│       └── nix.nix        # Nix daemon settings
└── home/
    └── programs/           # Standalone program configurations
        └── neovim-ide/     # Neovim Metals LSP setup scripts
```

## 🏗️ Configurations

### `default` - Personal Configuration

- **Username**: `mike`
- **Focus**: General development and personal projects
- **Includes**: All language toolchains, personal dotfiles

### `work` - Work Configuration

- **Username**: `chmc-h022fl97xj`
- **Focus**: Professional development with additional enterprise tools
- **Includes**: All `default` features plus custom library functions (Metals builder)
- **Extra**: Azure CLI, enterprise-specific tooling

## 🛠️ Managed Components

### Languages & Runtimes

- **Scala**: sbt, bloop, coursier, Metals LSP (custom build)
- **Rust**: Latest stable via fenix overlay, rust-analyzer
- **Zig**: Latest from Mitchell Hashimoto's overlay
- **Python**: Python 3.x with pip
- **Go**: Latest Go toolchain
- **OCaml**: opam, OCaml toolchain
- **Haskell**: GHC, Stack, Cabal
- **C#**: .NET SDK (including legacy 6.0 for compatibility)
- **Java**: OpenJDK 17
- **Node.js**: Node, npm, yarn
- **Lua**: Lua 5.x

### Development Tools

- **Editor**: Neovim nightly with treesitter, LSP, custom plugins
- **Version Control**: Git, lazygit, gh CLI
- **Containers**: Docker/Podman configurations
- **Databases**: SQL tools and clients
- **Infrastructure**: Terraform, Azure CLI

### Shell & Terminal

- **Shells**: Zsh (primary), Nushell (modern alternative)
- **Prompt**: Oh My Posh with custom `zen.toml` theme, Starship (alternative)
- **Multiplexers**: tmux, zellij
- **Completions**: Carapace for enhanced shell completions
- **Terminal**: Ghostty (primary), Alacritty (configured)

### CLI Utilities

- **Navigation**: zoxide (smart cd), yazi (file manager), eza (modern ls)
- **Search**: ripgrep, fd, fzf
- **File Tools**: bat (cat with syntax), tree, jq
- **Git UI**: lazygit
- **Misc**: curl, less, direnv, password-store

### Window Management & UI

- **Tiling**: Aerospace configuration, Yabai/SKHD dotfiles
- **Status Bar**: SketchyBar, borders (via Homebrew)
- **Launcher**: Raycast

### Fonts

- **Primary**: JetBrains Mono Nerd Font (via Nix)
- **Additional**: Hack Nerd Font (via Homebrew)

## 📝 Dotfiles

Dotfiles are managed in `modules/home-manager/home/dotfiles/` and automatically linked to `~/.config/`:

- **aerospace**: Window manager config (`aerospace.toml`)
- **alacritty**: Terminal emulator config with Catppuccin theme
- **ghostty**: Primary terminal config
- **gitkraken**: GitKraken themes (Catppuccin Macchiato)
- **nushell**: Modern shell config and env
- **ohmyposh**: Custom `zen.toml` and `zen.json` themes
- **skhd**: Keyboard shortcuts for yabai
- **starship**: Alternative prompt config
- **tmux**: Tmux configuration with custom scripts
- **yabai**: Tiling window manager config
- **yazi**: File manager config
- **zellij**: Modern multiplexer config
- **zsh**: Aliases, integrations, and Starship setup

### Utility Scripts

Custom scripts in `modules/home-manager/home/scripts/`:

- **tmux-sessionizer**: Fuzzy find and switch tmux sessions
- **tmux-cht.sh**: Quick cheatsheet lookup in tmux
- **zet**: Go-based second brain/zettelkasten tool

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

1. Create a new directory: `modules/darwin/your-tool/` or `modules/home-manager/your-tool/`
2. Add `default.nix` with your configuration
3. Import it in the parent `default.nix`

### Modifying Dotfiles

Dotfiles are managed as Nix sources. To modify:

1. Edit files in `modules/home-manager/home/dotfiles/`
2. Run `darwin-rebuild switch` to apply
3. Files are automatically linked to appropriate locations

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
2. Update Metals: `home/programs/neovim-ide/update-metals.nix`
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
