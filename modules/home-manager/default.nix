{
  pkgs,
  username,
  lib,
  extraHomePackages ? [ ],
  ...
}:
{
  # Merge machine-specific home packages with core configuration
  home.packages = extraHomePackages;

  imports = [
    ./home
    ./bat
    ./git
  ];
}
