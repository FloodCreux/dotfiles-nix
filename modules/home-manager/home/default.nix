{
  pkgs,
  lib,
  username,
  ...
}:

{
  nixpkgs.config = {
    allowUnfree = true;
    allowUnsupportedSystem = true;
    permittedInsecurePackages = [
      "dotnet-core-combined"
      "dotnet-sdk-6.0.428"
      "dotnet-sdk-wrapped-6.0.428"
      "dotnet-runtime-6.0.36"
      "dotnet-runtime-wrapped-6.0.36"
    ];
  };

  # Don't change this unless you know what you're doing
  home.stateVersion = "24.11";

  home.enableNixpkgsReleaseCheck = false;

  imports = [
    ./clang
    ./containers
    ./csharp
    ./git
    ./haskell
    ./java
    ./lua
    ./misc
    ./nix
    ./node
    ./notes
    ./scala
    ./sql
    ./terraform
    ./zig
  ];

  home.sessionVariables = {
    PAGER = "less";
    CLICLOLOR = 1;
    EDITOR = "nvim";
  };
}
