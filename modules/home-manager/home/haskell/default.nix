{
  config,
  lib,
  pkgs,
  ...
}:
{
  options.modules.haskell.enable = lib.mkEnableOption "Haskell";

  config = lib.mkIf config.modules.haskell.enable {
    home.packages = with pkgs; [
      ghc
      cabal-install
      zlib
    ];
  };
}
