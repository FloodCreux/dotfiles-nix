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
      "raycast"
      "fontforge"
      "nikitabobko/tap/aerospace"
    ];
    taps = [
      "azure/azd"
      # "scalacenter/bloop"
    ];
    brews = [
      "azd"
      "tree"
      "go"
      # "scalacenter/bloop/bloop"
      "openjdk@17"
      "libuv"
      "oh-my-posh"
    ];
  };
}
