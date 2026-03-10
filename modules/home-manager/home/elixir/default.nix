{
  config,
  lib,
  pkgs,
  ...
}:
{
  options.modules.elixir.enable = lib.mkEnableOption "Elixir";

  config = lib.mkIf config.modules.elixir.enable {
    home.packages = with pkgs; [
      elixir
      elixir-ls
    ];
  };
}
