{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    ocaml
    opam
  ];
}
