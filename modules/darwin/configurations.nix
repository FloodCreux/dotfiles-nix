{ pkgs, username }:

let
  nix = import ../shared/nix.nix;
in
{
  nix = nix;
  nixpkgs.config.allowUnfree = true;
  programs.zsh.enable = true;
  services.nix-daemon.enable = true;
  system.stateVersion = 4;
  users.users.${username}.home = "/Users/${username}";

  environment = {
    shells = with pkgs; [ bash zsh ];
    loginShell = pkgs.zsh;
    systemPackages = [ pkgs.coreutils ];
    systemPath = [ "/opt/homebrew/bin" ];
    pathsToLink = [ "/Applications" ];
  };

  system.keyboard.enableKeyMapping = true;

  fonts = {
    fontDir.enable = false;
    fonts = [ (pkgs.nerdfonts.override { fonts = [ "JetBrainsMono" ]; }) ];
  };

  system.defaults = {
    finder = {
      AppleShowAllFiles = true;
      _FXShowPosixPathInTitle = true;
    };

    dock.autohide = true;

    NSGlobalDomain = {
      AppleShowAllExtensions = true;
      InitialKeyRepeat = 14;
      KeyRepeat = 1;
    };
  };

  homebrew = {
    enable = true;
    caskArgs.no_quarantine = true;
    global.brewfile = true;
    masApps = { };
    casks = [ "devtoys" "dotnet-sdk" "raycast" ];
    taps = [ "azure/azd" ];
    brews = [ "azd" ];
  };
}
