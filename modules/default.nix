{ inputs }:
let
  home-manager = import ./home-manager;
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
          inherit pkgs;
          inherit username;
        })

        inputs.home-manager.darwinModules.home-manager
        {
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;
            users.${username} =
              { ... }:
              {
                imports = [
                  (home-manager {
                    inherit pkgs;
                    inherit username;
                  })
                ];
              };
          };
        }
      ];

      system = system;
    };

  metalsOverlay = metals;
}
