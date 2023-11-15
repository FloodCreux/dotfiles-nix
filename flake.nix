{
    description = "Development packages for Mike Flood";
    inputs = {
        # Where we get most of our sofware
        nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";

        # Manages configs links things into home directory
        home-manager.url = "github:nix-community/home-manager/master";
        home-manager.inputs.nixpkgs.follows = "nixpkgs";

        # Controls system level softwayre and settings including fonts
        darwin.url = "github:lnl7/nix-darwin";
        darwin.inputs.nixpkgs.follows = "nixpkgs";
    };
    outputs = inputs@{self, nixpkgs, home-manager, darwin, ...}: {
        darwinConfigurations = self.modules.mkDarwin { 
            system = "aarch64-darwin";
        }; 

        modules = import ./modules { inherit inputs; };
    };
}
