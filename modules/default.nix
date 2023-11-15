{ inputs }:
let
    home-manager = import ./home-manager { inherit inputs; };
in
{
    mkDarwin = { git ? { }, system, username }:
        inputs.darwin.lib.darwinSystem {
            system = system;
            pkgs = import inputs.nixpkgs { 
                inherit system;
                config.allowUnfree = true;
            };

            modules = [ 
                (import ./darwin/configurations.nix { inherit username; })

                inputs.home-manager.darwinModules.home-manager {
                    home-manager = {
                        useGlobalPkgs = true;
                        useUserPackages = true;
                        users.${username}.imports = [
                            home-manager
                        ];
                    };
                }
            ];
        };
}
