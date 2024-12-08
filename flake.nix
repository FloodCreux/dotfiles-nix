{
  description = "Development packages for Mike Flood";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    # home-manager.url = "github:nix-community/home-manager/release-24.05";
    home-manager.url = "github:nix-community/home-manager/master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    darwin.url = "github:lnl7/nix-darwin";
    darwin.inputs.nixpkgs.follows = "nixpkgs";

    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";

    zig.url = "github:mitchellh/zig-overlay";

    # rust overlay
    fenix = {
      url = "github:nix-community/fenix/monthly";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    neovim-flake = {
      url = "/Users/mike/personal/neovim-ide";
      # url = "github:FloodCreux/neovim-ide";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    inputs@{
      nixpkgs,
      home-manager,
      darwin,
      ...
    }:
    let
      pkgs-config = {
        allowUnfree = true;
        allowUnsupportedSystem = true;
        permittedInsecurePackages = [
          "dotnet-core-combined"
          "dotnet-sdk-6.0.428"
          "dotnet-sdk-wrapped-6.0.428"
          "dotnet-runtime-6.0.36"
        ];
      };

    in
    {
      darwinConfigurations = {
        default =
          let
            system = "aarch64-darwin";
            overlays = import ./lib/overlays.nix { inherit inputs system username; } ++ [
              inputs.neovim-flake.overlays.${system}.default
            ];
            pkgs = import nixpkgs {
              inherit overlays system;

              config = pkgs-config;
            };

            username = "mike";

          in
          darwin.lib.darwinSystem {
            inherit system;

            pkgs = pkgs;

            modules = [
              (import ./modules/darwin {
                inherit pkgs;
                inherit username;
              })

              home-manager.darwinModules.home-manager
              {
                home-manager = {
                  useGlobalPkgs = true;
                  useUserPackages = true;
                  users.${username} = {
                    imports = [
                      inputs.neovim-flake.homeManagerModules.${system}.nvim
                      (import ./modules/home-manager {
                        inherit inputs;
                        inherit pkgs;
                        inherit username;
                      })
                    ];
                  };
                };
              }
            ];
          };

        work =
          let
            system = "aarch64-darwin";
            pkgs = import nixpkgs {
              inherit system;

              config = pkgs-config;
              overlays = import ./lib/overlays.nix { inherit inputs system username; } ++ [
                inputs.neovim-flake.overlays.${system}.default
              ];
            };

            username = "chmc-h022fl97xj";
          in
          darwin.lib.darwinSystem {
            inherit system;

            pkgs = pkgs;

            modules = [
              (import ./modules/darwin {
                inherit pkgs;
                inherit username;
              })

              home-manager.darwinModules.home-manager
              {
                home-manager = {
                  useGlobalPkgs = true;
                  useUserPackages = true;
                  users.${username} = {
                    imports = [
                      inputs.neovim-flake.homeManagerModules.${system}.nvim
                      (import ./modules/home-manager {
                        inherit pkgs;
                        inherit username;
                      })
                    ];
                  };
                };
              }
            ];
          };
      };
    };
}
