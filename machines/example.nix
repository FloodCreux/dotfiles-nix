# Example machine-specific configuration
# Copy this file and customize for your machine.
#
# Machine configs are standard nix-darwin modules. They can set any
# nix-darwin option, and toggle home-manager modules via the
# home-manager.users.${username} path.
#
# Principle:
#   - home.packages (via home-manager) = all user dev tools
#   - programs.<name> (via home-manager) = tools with declarative config (git, bat)
#   - environment.systemPackages = ONLY machine-specific system tools (awscli, k9s)
#   - modules.netskope.enable = darwin-level system integration (SSL certs, env vars)

{ pkgs, username, ... }:
{
  # Machine-specific system packages (not general dev tools)
  environment.systemPackages = with pkgs; [
    # Add machine-specific CLI tools here
    # Example: awscli2, k9s, docker, etc.
  ];

  # Darwin-level options:
  # modules.netskope.enable = true;  # For work machines behind corporate proxies

  # Toggle dev tool modules on/off (all enabled by default):
  # home-manager.users.${username}.modules.clang.enable = false;
  # home-manager.users.${username}.modules.elixir.enable = false;
  # home-manager.users.${username}.modules.go.enable = false;
  # home-manager.users.${username}.modules.hadoop.enable = false;
  # home-manager.users.${username}.modules.haskell.enable = false;
  # home-manager.users.${username}.modules.java.enable = false;
  # home-manager.users.${username}.modules.lua.enable = false;
  # home-manager.users.${username}.modules.nixd.enable = false;
  # home-manager.users.${username}.modules.node.enable = false;
  # home-manager.users.${username}.modules.nvim.enable = false;
  # home-manager.users.${username}.modules.ocaml.enable = false;
  # home-manager.users.${username}.modules.python.enable = false;
  # home-manager.users.${username}.modules.rust.enable = false;
  # home-manager.users.${username}.modules.scala.enable = false;
  # home-manager.users.${username}.modules.sql.enable = false;
  # home-manager.users.${username}.modules.yazi.enable = false;
}
