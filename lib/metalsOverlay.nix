{ ... }:

f: p:

{
  metals = p.callPackage ./metalsBuilder.nix { pkgs = p; };
}
