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

    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
    zig.url = "github:mitchellh/zig-overlay";
    ghostty.url = "github:ghostty-org/ghostty";

    fenix = {
      url = "github:nix-community/fenix/monthly";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    inputs@{ flake-parts, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [ "aarch64-darwin" ];
      perSystem = { system, pkgs, ... }: { };

      flake = {
        darwinConfigurations =
          let
            darwin = inputs.darwin;

            pkgs-config = {
              allowUnfree = true;
              allowUnsupportedSystem = true;
              permittedInsecurePackages = [
                "dotnet-core-combined"
                "dotnet-sdk-6.0.428"
                "dotnet-sdk-wrapped-6.0.428"
                "dotnet-runtime-6.0.36"
                "dotnet-runtime-wrapped-6.0.36"
              ];
            };

            mkDarwinSystem =
              {
                username,
                system ? "aarch64-darwin",
              }:
              let
                lib = if username == "chmc-h022fl97xj" then import ./lib { inherit pkgs inputs; } else null;
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
                  ;
              };
          in
          {
            default = mkDarwinSystem { username = "mike"; };
            work = mkDarwinSystem { username = "chmc-h022fl97xj"; };
          };
      };
    };
}
