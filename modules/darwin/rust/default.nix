{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    (fenix.complete.withComponents [
      "cargo"
      "clippy"
      "rust-src"
      "rustc"
      "rustfmt"
    ])
    # MOVED TO BREW FOR NOW
    # rust-analyzer-nightly
  ];
}
