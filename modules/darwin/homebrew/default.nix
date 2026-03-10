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
