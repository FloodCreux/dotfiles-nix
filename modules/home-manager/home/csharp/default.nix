{ pkgs, ... }:
{
  home.packages = with pkgs; [
    # omnisharp-roslyn
    # roslyn
    csharp-ls
    # netcoredbg
    # csharpier
  ];
}
