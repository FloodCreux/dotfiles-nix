{
  inputs,
  system,
  username,
}:

with inputs;

let
  metalsOverlay = f: p: { };

  lib = import ../lib { inherit pkgs inputs plugins; };

  libOverlay = f: p: {
    lib = p.lib.extend (
      _: _: {
        inherit (lib)
          mkVimBool
          withAttrSet
          withPlugins
          writeIf
          ;
      }
    );
  };

  buildersOverlay = f: p: {
    mkDarwin =
      {
        darwin,
        system,
        pkgs,
        username,
      }:
      darwin.lib.darwinSystem {
        inherit system;

        pkgs = pkgs;

        modules = [
          (import ../modules/darwin {
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
                  inputs.neovim-flake.homeManagerModules.${system}.nvim
                  (import ../modules/home-manager {
                    inherit inputs;
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

  treesitterGrammarsOverlay = f: p: {
    treesitterGrammars = _.withPlugins (p: [
      p.tree-sitter-scala
      p.tree-sitter-nix
    ]);
  };

  nvim-nighlty-overlay = inputs.neovim-nightly-overlay.overlays.default;

  rustOverlay = inputs.fenix.overlays.default;

  zigOverlay = f: p: {
    zigpkgs = zig.packages.${p.system};
  };
in
[
  libOverlay
  metalsOverlay
  nvim-nighlty-overlay
  neovim-flake.overlays.${system}.default
  buildersOverlay
  treesitterGrammarsOverlay
  rustOverlay
  zigOverlay
]
