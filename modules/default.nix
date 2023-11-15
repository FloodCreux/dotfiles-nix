{ inputs }:
let
    darwin = import ./darwin { inherit inputs; };
    home-manager = import ./home-manager { inherit inputs; };
in
{
    mkDarwin = { git ? { }, system, username }:
        inputs.darwin.lib.darwinSystem {
            system = system;

            modules = [ 
                darwin

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
