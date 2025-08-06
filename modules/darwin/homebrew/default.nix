{ ... }:
{
  homebrew = {
    enable = true;
    caskArgs.no_quarantine = true;
    global.brewfile = true;
    masApps = { };
    casks = [
      "devtoys"
      "raycast"
      "fontforge"
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
      "imagemagick"
    ];
  };
}
