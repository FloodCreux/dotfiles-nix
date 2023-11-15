{
    description = "Development packages for Mike Flood";
    inputs = {
        # Where we get most of our sofware
        nixpkgs.url = "github:nixos/nixpkgs/nixos-23.05";
        nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

        # Manages configs links things into home directory
        home-manager.url = "github:nix-community/home-manager/release-23.05";
        home-manager.inputs.nixpkgs.follows = "nixpkgs";

        # Controls system level softwayre and settings including fonts
        darwin.url = "github:lnl7/nix-darwin";
        darwin.inputs.nixpkgs.follows = "nixpkgs";
    };

    outputs = inputs@{flake-parts, self, ...}: 
    let
      git = {
          extraConfig.github.user = username;
          userEmail = "flood.mike@gmail.com";
          userName = "FloodCreux";
      };
      username = "mike";
    in 
        flake-parts.lib.mkFlake { inherit inputs; } {
            systems = [ "aarch64-darwin" ];
            perSystem = { config, self', inputs', pkgs, system, ... }: {
                packages = {
                    mike-nvim = pkgs.vimUtils.buildVimPlugin {
                        name = "mike";
                        src = ./config/nvim;
                    };
                };
            };

            flake = {
                darwinConfigurations = {
                    mike = self.lib.mkDarwin { 
                        inherit git username;
                        system = "aarch64-darwin";
                    };
                    Mikes-MacBook-Pro = self.lib.mkDarwin { 
                        inherit git username;
                        system = "aarch64-darwin";
                    };
                };

                lib = import ./modules { inherit inputs; };

            };
        };
}
