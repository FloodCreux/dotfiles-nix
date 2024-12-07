{
  inputs,
  system,
  username,
}:

with inputs;

let
  metalsOverlay = f: p: { };

  libVersionOverlay = import "${inputs.nixpkgs}/lib/flake-version-info.nix" inputs.nixpkgs;

  libOverlay = f: p: rec {
    libx = import ./. { inherit (p) lib; };
    lib =
      (p.lib.extend (
        _: _: {
          inherit (libx) exe removeNewline secretManager;
        }
      )).extend
        libVersionOverlay;
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
