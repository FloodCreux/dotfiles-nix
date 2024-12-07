{ pkgs, username, ... }:
(import ./modules/home-manager {
  inherit pkgs;
  inherit username;
})
