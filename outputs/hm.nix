{
  extraPkgs,
  inputs,
  system,
  pkgs,
  ...
}:

with inputs;
let
  sharedImports = [
    # ../home/wm/mac.nix

    neovim-flake.homeManagerModules.${system}.default
    { home.packages = extraPkgs; }
    { nix.registry.nixpkgs.flake = inputs.nixpkgs; }
  ];

  mkMacHome =
    { }:
    (home-manager.lib.homeManagerConfiguration {
      inherit pkgs;
      modules = sharedImports;
    });
in
{
  mac-arm = mkMacHome { };
}
