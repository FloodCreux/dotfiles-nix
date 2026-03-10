{
  config,
  lib,
  pkgs,
  ...
}:
{
  options.modules.ocaml.enable = lib.mkEnableOption "OCaml";

  config = lib.mkIf config.modules.ocaml.enable {
    environment.systemPackages = with pkgs; [
      ocaml
      opam
      dune_3
      ocamlPackages.ocamlformat
      ocamlPackages.lsp
    ];
  };
}
