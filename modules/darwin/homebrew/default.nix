# Ensure Homebrew is installed and configured on the machine via nix-darwin.
# Package management (casks, brews, taps) is handled externally.
{ ... }:
{
  homebrew = {
    enable = true;
    onActivation.cleanup = "none";
    caskArgs.no_quarantine = true;
    global.brewfile = true;
    masApps = { };
    casks = [ ];
    taps = [ ];
    brews = [ ];
  };
}
