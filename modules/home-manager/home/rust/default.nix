{
  config,
  lib,
  pkgs,
  ...
}:
{
  options.modules.rust.enable = lib.mkEnableOption "Rust";

  config = lib.mkIf config.modules.rust.enable {
    home.packages = [
      (pkgs.fenix.complete.withComponents [
        "cargo"
        "clippy"
        "rust-src"
        "rustc"
        "rustfmt"
      ])
    ];
  };
}
