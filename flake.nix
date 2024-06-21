{
  description = "Development packages for Mike Flood";
  inputs = {
    # Where we get most of our sofware
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    # Manages configs links things into home directory
    home-manager.url = "github:nix-community/home-manager/release-24.05";
    # home-manager.url = "github:nix-community/home-manager/master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    # Controls system level software and settings including fonts
    darwin.url = "github:lnl7/nix-darwin";
    darwin.inputs.nixpkgs.follows = "nixpkgs";

    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";

    nixvim = { url = "github:FloodCreux/nixvim"; };

    zig.url = "github:mitchellh/zig-overlay";
  };

  outputs =
    inputs@{ flake-parts, self, ... }:
    let
      username = "mike";
      nixpkgs = inputs.nixpkgs-unstable;
      nvim-overlay = inputs.neovim-nightly-overlay.overlays.default;
      zigpkgs = inputs.zig.packages;
    in flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [ "aarch64-darwin" ];
      perSystem = { self, system, ... }: { };

      flake = {
        darwinConfigurations = {
          default = self.lib.mkDarwin {
            inherit username;
            system = "aarch64-darwin";
            pkgs = import nixpkgs {
              system = "aarch64-darwin";
              config = {
                allowUnfree = true;
                allowUnsupportedSystem = true;
              };
              overlays = [ 
                nvim-overlay
                (final: prev: {
                  zigpkgs = zigpkgs.${prev.system};
                })
              ];
            };
          };

          work = self.lib.mkDarwin {
            username = "chmc-h022fl97xj";
            system = "aarch64-darwin";
            pkgs = import nixpkgs {
              system = "aarch64-darwin";
              config = {
                allowUnfree = true;
                allowUnsupportedSystem = true;
              };
              overlays = [ 
                nvim-overlay
                (final: prev: {
                  zigpkgs = zigpkgs.${prev.system};
                })
              ];
            };
          };
        };

        lib = import ./modules { inherit inputs; };
      };
    };
}
