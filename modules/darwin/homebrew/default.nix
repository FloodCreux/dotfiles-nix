{ ... }:
{
  homebrew = {
    enable = true;
    caskArgs.no_quarantine = true;
    global.brewfile = true;
    masApps = { };
    casks = [
      "devtoys"
      "dotnet-sdk"
      # is available in nix... lower version
      "raycast"
      "fontforge"
      # is available in nix... v0.15, this is 0.16
      "nikitabobko/tap/aerospace"
    ];
    taps = [
      "azure/azd"
      # "scalacenter/bloop"
    ];
    brews = [
      "azd"
      # "scalacenter/bloop/bloop"
      "openjdk@17"
      "libuv"
    ];
  };
}
