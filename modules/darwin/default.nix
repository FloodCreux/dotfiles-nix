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
    yazi
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
    taps = [ "azure/azd" "scalacenter/bloop" ];
    brews = [ "azd" "opam" "tree" "yabai" "azure-cli" "rustup" "go" "scalacenter/bloop/bloop" "openjdk@17" "libuv" ];
  };
}
