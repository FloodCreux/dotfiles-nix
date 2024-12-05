{
  description = "Development packages for Mike Flood";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager.url = "github:nix-community/home-manager/release-24.05";
    # home-manager.url = "github:nix-community/home-manager/master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    darwin.url = "github:lnl7/nix-darwin";
    darwin.inputs.nixpkgs.follows = "nixpkgs";

    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";

    nixvim = {
      url = "github:FloodCreux/nixvim";
    };

    zig.url = "github:mitchellh/zig-overlay";
    fenix = {
      url = "github:nix-community/fenix/monthly";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    inputs@{
      nixpkgs,
      home-manager,
      darwin,
      fenix,
      ...
    }:
    let
      nvim-overlay = inputs.neovim-nightly-overlay.overlays.default;
      zigpkgs = inputs.zig.packages;
      overlays = [
        nvim-overlay
        (final: prev: { zigpkgs = zigpkgs.${prev.system}; })
        fenix.overlays.default
      ];
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
            pkgs = import nixpkgs {
              system = "aarch64-darwin";

              config = pkgs-config;
              overlays = overlays;
            };

            username = "mike";
          in
          darwin.lib.darwinSystem {
            system = "aarch64-darwin";

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

        work =
          let
            pkgs = import nixpkgs {
              system = "aarch64-darwin";

              config = pkgs-config;
              overlays = overlays;
            };

            username = "chmc-h022fl97xj";
          in
          darwin.lib.darwinSystem {
            system = "aarch64-darwin";

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

      lib = import ./modules { inherit inputs; };
    };
}
