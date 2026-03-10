{ inputs, system }:

let
  metalsOverlay = import ./metalsOverlay.nix { };

  treesitterGrammarsOverlay = f: p: {
    treesitterGrammars = p.tree-sitter.withPlugins (p: [
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
      p.tree-sitter-terraform
      p.tree-sitter-yaml
      p.tree-sitter-make
      p.tree-sitter-html
      p.tree-sitter-bash
      p.tree-sitter-ocaml
      p.tree-sitter-c-sharp
      p.tree-sitter-lua
      p.tree-sitter-luadoc
      p.tree-sitter-nu
      p.tree-sitter-hocon
      p.tree-sitter-haskell
      p.tree-sitter-elixir
      p.tree-sitter-python
    ]);
  };

  nvim-nightly-overlay = inputs.neovim-nightly-overlay.overlays.default;

  rustOverlay = inputs.fenix.overlays.default;

in
[
  metalsOverlay
  nvim-nightly-overlay
  treesitterGrammarsOverlay
  rustOverlay
]
