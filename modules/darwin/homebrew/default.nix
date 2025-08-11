{ ... }:
{
  homebrew = {
    enable = true;
    caskArgs.no_quarantine = true;
    global.brewfile = true;
    masApps = { };
    casks = [
      "devtoys"
      "font-hack-nerd-font"
      "fontforge"
      "ghostty"
      "nikitabobko/tap/aerospace"
      "raycast"
    ];
    taps = [
      "azure/azd"
      "FelixKratz/formulae"
      "scalacenter/bloop"
    ];
    brews = [
      "azd"
      "borders"
      "dotenv"
      "ghostscript"
      "imagemagick"
      "libuv"
      "mermaid-cli"
      "openjdk@17"
      "scalacenter/bloop/bloop"
      "sketchybar"
      "tectonic"
      "tmux"
      "tree-sitter"
      "zsh-autosuggestions"
    ];
  };
}
