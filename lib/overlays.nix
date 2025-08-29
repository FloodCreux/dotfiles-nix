{
  lib,
  inputs,
  system,
  username,
}:

with inputs;

let
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
    inherit (lib) metalsBuilder;

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
              users.${username} = {
                imports = [
                  (import ../modules/home-manager {
                    inherit inputs;
                    inherit pkgs;
                    inherit username;
                    inherit lib;
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
      p.tree-sitter-c
      p.tree-sitter-rust
      p.tree-sitter-markdown
      p.tree-sitter-markdown-inline
      p.tree-sitter-comment
      p.tree-sitter-json
      p.tree-sitter-toml
      p.tree-sitter-zig
      p.tree-sitter-vim
      p.tree-sitter-vimdoc
      p.tree-sitter-hcl
      # p.tree-sitter-terraform
      p.tree-sitter-yaml
      p.tree-sitter-make
      p.tree-sitter-html
      p.tree-sitter-bash
      p.tree-sitter-ocaml
      # Broken, need to manually :TSInstall c_sharp
      # p.tree-sitter-c-sharp
      p.tree-sitter-lua
      # p.tree-sitter-luadoc
      p.tree-sitter-nu
      p.tree-sitter-hocon
      p.tree-sitter-haskell
      p.tree-sitter-elixir
      p.tree-sitter-python
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
  lib.metalsOverlay
  nvim-nighlty-overlay
  buildersOverlay
  treesitterGrammarsOverlay
  rustOverlay
  zigOverlay
  # yazi.overlays.default
]
