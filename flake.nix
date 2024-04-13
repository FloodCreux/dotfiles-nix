{
  description = "Development packages for Mike Flood";
  inputs = {
    # Where we get most of our sofware
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    # Manages configs links things into home directory
    home-manager.url = "github:nix-community/home-manager/release-23.11";
    # home-manager.url = "github:nix-community/home-manager/master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    # Controls system level software and settings including fonts
    darwin.url = "github:lnl7/nix-darwin";
    darwin.inputs.nixpkgs.follows = "nixpkgs";

    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";

    nixvim = { url = "github:FloodCreux/nixvim"; };
  };

  outputs =
    inputs@{ flake-parts, self, nixpkgs-unstable, neovim-nightly-overlay, ... }:
    let
      username = "mike";
      nixpkgs = nixpkgs-unstable;
      nvim = neovim-nightly-overlay;
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
              overlays = [ nvim.overlays.default ];
            };
          };
        };

        lib = import ./modules { inherit inputs; };
      };
    };
}
