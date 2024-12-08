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
    mkHomeConfigurations =
      {
        pkgs ? f,
        extraPkgs ? [ ],
      }:
      import ../outputs/hm.nix {
        inherit
          extraPkgs
          inputs
          pkgs
          system
          username
          ;
      };
  };

  treesitterGrammarsOverlay = f: p: {
    treesitterGrammars = _.withPlugins (p: [
      p.tree-sitter-scala
      p.tree-sitter-nix
    ]);
  };

  rustOverlay = inputs.fenix.overlays.default;

  zigOverlay = f: p: {
    zigpkgs = zig.packages.${p.system};
  };
in
[
  libOverlay
  metalsOverlay
  neovim-flake.overlays.${system}.default
  buildersOverlay
  treesitterGrammarsOverlay
  rustOverlay
  zigOverlay
]
