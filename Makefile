.PHONY: help check build switch update fmt format clean

# Default target
help:
	@echo "Available commands:"
	@echo "  make check      - Validate flake configuration"
	@echo "  make build      - Build the configuration without activating"
	@echo "  make switch     - Build and activate the configuration"
	@echo "  make update     - Update all flake inputs"
	@echo "  make fmt        - Format all Nix files"
	@echo "  make clean      - Remove build artifacts"

# Validate configuration
check:
	nix flake check

# Build configuration without activating
build:
	darwin-rebuild build --flake .

# Build and activate configuration
switch:
	darwin-rebuild switch --flake .

# Update flake inputs
update:
	nix flake update

# Format Nix files
fmt format:
	nixfmt **/*.nix

# Clean build artifacts
clean:
	rm -rf result result-* target/
