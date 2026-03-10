# Example machine-specific configuration
# Copy this file and customize for your machine.
#
# Machine configs are standard nix-darwin modules. They can set any
# nix-darwin or home-manager option, and toggle feature modules on/off.

{ pkgs, username, ... }:
{
  # Additional system packages for this machine only
  environment.systemPackages = with pkgs; [
    # Add machine-specific CLI tools here
    # Example: docker, kubernetes-cli, etc.
  ];

  # Toggle darwin-level modules on/off:
  # modules.rust.enable = false;
  # modules.python.enable = false;
  # modules.scala.enable = false;
  # modules.ocaml.enable = false;
  # modules.go.enable = false;
  # modules.nvim.enable = false;
  # modules.nixd.enable = false;
  # modules.yazi.enable = false;

  # Enable Netskope SSL inspection (for work machines behind corporate proxies):
  # modules.netskope.enable = true;

  # Toggle home-manager-level modules via home-manager config:
  # home-manager.users.${username}.modules.java.enable = false;
  # home-manager.users.${username}.modules.haskell.enable = false;
  # home-manager.users.${username}.modules.elixir.enable = false;
  # home-manager.users.${username}.modules.clang.enable = false;
  # home-manager.users.${username}.modules.lua.enable = false;
  # home-manager.users.${username}.modules.node.enable = false;
  # home-manager.users.${username}.modules.scala.enable = false;
  # home-manager.users.${username}.modules.sql.enable = false;
}
