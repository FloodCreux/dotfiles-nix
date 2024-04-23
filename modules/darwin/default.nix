{ pkgs, username }:

let nix = import ../shared/nix.nix;
in {
  nix = nix;
  nixpkgs.config.allowUnfree = true;
  programs.zsh.enable = true;
  services.nix-daemon.enable = true;
  system.stateVersion = 4;
  users.users.${username}.home = "/Users/${username}";

  environment.systemPackages = with pkgs; [ 
    neovim 
    zigpkgs.master 
    templ 
    air
  ];

  system.keyboard.enableKeyMapping = true;

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
    casks = [ "devtoys" "dotnet-sdk" "raycast" "fontforge" ];
    taps = [ "azure/azd" ];
    brews = [ "azd" "opam" "tree" "yabai" "azure-cli" "openjdk@17" "rustup" "go" ];
  };
}
