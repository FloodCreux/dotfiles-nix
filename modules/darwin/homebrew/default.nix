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
      "scalacenter/bloop"
    ];
    brews = [
      "azd"
      "tree"
      "azure-cli"
      "go"
      "scalacenter/bloop/bloop"
      "openjdk@17"
      "libuv"
      "pipx"
      "sbt"
      "oh-my-posh"
    ];
  };
}
