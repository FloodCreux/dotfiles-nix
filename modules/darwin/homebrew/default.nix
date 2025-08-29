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
      "direnv"
      "eza"
      "ghostscript"
      "gpatch"
      "ffmpeg"
      "imagemagick"
      "libuv"
      "mermaid-cli"
      "opam"
      "openjdk@17"
      "rust-analyzer"
      "scalacenter/bloop/bloop"
      "sketchybar"
      "tectonic"
      "tmux"
      "tree-sitter"
      "zsh-autosuggestions"
    ];
  };
}
