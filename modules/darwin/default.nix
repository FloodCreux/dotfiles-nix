{ inputs }:
let
  pkgs = inputs.nixpkgs;
in
{
  # here go the darwin preferences and config items
  programs.zsh.enable = true;

  environment = {
    shells = with pkgs; [ bash zsh ];
    loginShell = pkgs.zsh;
    systemPackages = [ pkgs.coreutils ];
    systemPath = [ "/opt/homebrew/bin" ];
    pathsToLink = [ "/Applications" ];
  };

  nix.extraOptions = ''
    experiments-features = nix-command flakes
  '';
  systemPackages = [ pkgs.coreutils ];
  system.keyboard.enableKeyMapping = true;

  fonts = {
    fontDir.enable = false; # DANGER: if set to true it will only install fonts listed below
    fonts = [ (pkgs.nerdfonts.override { fonts = [ "JetBrainsMono" ]; }) ];
  };

  services.nix-daemon.enable = true;

  system.defaults = {
    finder = {
      AppleShowAllExtensions = true;
      _FXShowPosixPathInTitle = true;
    };

    dock.autohide = true;

    NSGlobalDomain = {
      AppleShowAllExtensions = true;
      InitialKeyRepeat = 14;
      KeyRepeat = 1;
    };
  };
  # backwards compat; don't change
  system.stateVersion = 4;
  homebrew = {
    enable = true;
    caskArgs.no_quarantine = true;
    global.brewfile = true;
    masApps = { };
    casks = [ "devtoys" "wezterm" "dotnet-sdk" "raycast" ];
    taps = [ ];
    brews = [ ];
  };
}

