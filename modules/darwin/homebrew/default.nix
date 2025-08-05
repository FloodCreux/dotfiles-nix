{ ... }:
{
  homebrew = {
    enable = true;
    caskArgs.no_quarantine = true;
    global.brewfile = true;
    masApps = { };
    casks = [
      "devtoys"
      # is available in nix... lower version
      "raycast"
      "fontforge"
      # is available in nix... v0.15, this is 0.16
      "nikitabobko/tap/aerospace"
      "ghostty"
      "font-hack-nerd-font"
    ];
    taps = [
      "azure/azd"
      "scalacenter/bloop"
      "FelixKratz/formulae"
    ];
    brews = [
      "azd"
      "scalacenter/bloop/bloop"
      "openjdk@17"
      "libuv"
      "sketchybar"
      "tmux"
      "borders"
    ];
  };
}
