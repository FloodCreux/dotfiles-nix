{ ... }:

f: p:

let
  builder = p.callPackage ./builder.nix { pkgs = p; };
in
{
  metals = builder {
    version = "1.0.1";
    outputHash = "sha256-AamUE6mr9fwjbDndQtzO2Yscu2T6zUW/DiXMYwv35YE=";
  };
}
