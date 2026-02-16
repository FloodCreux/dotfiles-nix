{
  description = "Development packages for Mike Flood";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    flake-parts.url = "github:hercules-ci/flake-parts";

    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    darwin = {
      url = "github:lnl7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    neovim-nightly-overlay = {
      url = "github:nix-community/neovim-nightly-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    zig.url = "github:mitchellh/zig-overlay";

    fenix = {
      url = "github:nix-community/fenix/monthly";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    inputs@{ flake-parts, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [ "aarch64-darwin" ];
      perSystem =
        { system, pkgs, ... }:
        {
          formatter = pkgs.nixfmt-tree;
        };

      flake = {
        # Helper function to generate configurations for any username
        lib.mkDarwinSystem =
          {
            username,
            system ? "aarch64-darwin",
            machineConfig ? null,
          }:
          let
            darwin = inputs.darwin;

            pkgs-config = {
              allowUnfree = true;
              allowUnsupportedSystem = true;
            };

            lib = import ./lib { inherit pkgs inputs; };
            overlays = import ./lib/overlays.nix (
              { inherit inputs system username; } // (if lib != null then { inherit lib; } else { })
            );
            pkgs = import inputs.nixpkgs {
              inherit system overlays;
              config = pkgs-config;
            };
          in
          pkgs.mkDarwin {
            inherit
              darwin
              system
              pkgs
              username
              machineConfig
              ;
          };

        darwinConfigurations =
          let
            mkDarwinSystem = inputs.self.lib.mkDarwinSystem;

            users = [
              "mike"
              "chmc-h022fl97xj"
              # Add more usernames as needed
            ];

            # Generate a configuration for each username
            mkConfigs = builtins.listToAttrs (
              map (username: {
                name = username;
                value = mkDarwinSystem { inherit username; };
              }) users
            );
          in
          mkConfigs
          // {
            # Keep aliases for convenience
            default = mkDarwinSystem { username = "mike"; };
            work = mkDarwinSystem {
              username = "chmc-h022fl97xj";
              machineConfig = ./machines/work.nix;
            };

            # Hostname-based configuration (darwin-rebuild auto-detects this)
            "CHMC-H022FL97XJs-MacBook-Pro" = mkDarwinSystem {
              username = "chmc-h022fl97xj";
              machineConfig = ./machines/work.nix;
            };
          };
      };
    };
}
