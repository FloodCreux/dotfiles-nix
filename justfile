# Default target: list available commands
default:
    @just --list

# Validate flake configuration
check:
    nix flake check

# Build the configuration without activating
build:
    darwin-rebuild build --flake .

# Build and activate the configuration
switch:
    sudo darwin-rebuild switch --flake .

# Update all flake inputs
update:
    nix flake update

# Format all Nix files
fmt:
    nixfmt **/*.nix

# Format all Nix files (alias)
alias format := fmt

# Remove build artifacts
clean:
    rm -rf result result-* target/

# Run nix garbage collection
gc:
    nix-collect-garbage -d
