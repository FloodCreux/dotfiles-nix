{
  extraPkgs,
  inputs,
  system,
  pkgs,
  username,
  ...
}:

with inputs;
let
  sharedImports = [
    neovim-flake.homeManagerModules.${system}.default
    { home.packages = extraPkgs; }
    { nix.registry.nixpkgs.flake = inputs.nixpkgs; }
  ];

  mkMacHome =
    { }:
    let
      macHome = import ../home/wm/mac.nix { inherit pkgs username; };
      imports = sharedImports ++ [ macHome ];
    in
    (home-manager.darwinModules.home-manager {
      home-manager = {
        useGlobalPkgs = true;
        useUserPackages = true;
        users.${username} = {
          imports = imports;
        };
      };
    });
in
{
  mac-arm = mkMacHome { };
}
