{ inputs }:
let
  home-manager = import ./home-manager { inherit inputs; };
  metals = import ./metals { inherit inputs; };
in
{
  mkDarwin = { git ? { }, system, username }:
    inputs.darwin.lib.darwinSystem {
      modules = [
        (import ./darwin/configurations.nix { inherit username; })

        inputs.home-manager.darwinModules.home-manager
        {
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;
            users.${username} = { pkgs, ... }: {
              imports = [
                (home-manager { inherit git; })
              ];
            };
          };
        }
      ];

      system = system;
    };

  metalsOverlay = metals;
}
