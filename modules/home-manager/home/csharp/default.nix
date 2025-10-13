{ pkgs, ... }:
{
  home.packages = with pkgs; [
    (
      with dotnetCorePackages;
      combinePackages [
        sdk_10_0
        sdk_9_0
        sdk_8_0
      ]
    )
    omnisharp-roslyn
    roslyn
    csharp-ls
    netcoredbg
    csharpier
  ];
}
