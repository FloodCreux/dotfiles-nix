{ pkgs, ... }:

let
  metalsBuilder = import ./metalsBuilder.nix { inherit pkgs; };
  metalsOverlay = import ./metalsOverlay.nix { };
in
{
  inherit metalsBuilder metalsOverlay;
}
