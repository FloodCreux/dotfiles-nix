{ username, ... }:
{
  system.primaryUser = username;
  system.stateVersion = 6;
  system.keyboard.enableKeyMapping = true;
  system.defaults = {
    dock = {
      autohide = true;
      autohide-delay = 0.0;
      autohide-time-modifier = 0.2;
      tilesize = 48;
      minimize-to-application = true;
    };

    finder = {
      AppleShowAllFiles = true;
      _FXShowPosixPathInTitle = true;
      FXEnableExtensionChangeWarning = false;
      ShowPathbar = true;
      ShowStatusBar = true;
    };

    NSGlobalDomain = {
      AppleShowAllExtensions = true;
      InitialKeyRepeat = 15;
      KeyRepeat = 1;
      AppleInterfaceStyle = "Dark";
      AppleShowScrollBars = "WhenScrolling";
    };
  };

  ids.gids.nixbld = 30000;
}
