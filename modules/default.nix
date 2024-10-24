{ inputs }:
let
  home-manager = import ./home-manager { inherit inputs; };
  metals = import ./metals { inherit inputs; };
in
{
  mkDarwin =
    {
      system,
      pkgs,
      username,
    }:
    inputs.darwin.lib.darwinSystem {
      modules = [
        (import ./darwin {
          inherit username;
          inherit pkgs;
        })

        inputs.home-manager.darwinModules.home-manager
        {
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;
            users.${username} =
              { pkgs, ... }:
              {
                imports = [ (home-manager { inherit system; }) ];
              };
          };
        }
      ];

      system = system;
    };

  metalsOverlay = metals;
}
