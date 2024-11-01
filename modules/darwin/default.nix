{ pkgs, username, ... }:

let
  nix = import ../shared/nix.nix;
in
{
  nix = nix;

  nixpkgs.config.allowUnfree = true;
  programs.zsh.enable = true;
  services.nix-daemon.enable = true;
  system.stateVersion = 4;

  users.users.${username} = {
    home = "/Users/${username}";
    shell = pkgs.nushell;
  };

  environment.systemPackages = with pkgs; [
    neovim
    zigpkgs.master

    templ
    yazi

    jq
    curl
    gh
    less
    fd
    ripgrep

    nixd

    nushell
    carapace
    oh-my-posh

    skhd

    zoxide
  ];

  environment.shellAliases = {
    tf = "terraform";
    code = "open -a 'Visual Studio Code'";
    ls = "ls --color";
    vim = "nvim";
    vimdiff = "nvim -d";
    c = "clear";
    grep = "grep --color";
    nixswitch = "darwin-rebuild switch --flake ~/personal/nix/.#default";
    nixup = "pushd ~/personal/nix; nix flake update; nixswitch; popd";
    wixswitch = "darwin-rebuild switch --flake ~/personal/nix/.#work";
    wixup = "pushd ~/personal/nix; nix flake update; wixswitch; popd";
    flushdns = "sudo dscacheutil -flushcache; sudo killall -HUP mDNSResponder";
    tmux-sessionizer = "sh ~/.local/scripts/tmux-sessionizer";
  };

  environment.shells = [ pkgs.nushell ];

  environment.variables = {
    XDG_CONFIG_HOME = "$HOME/.config";
  };

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
    casks = [
      "devtoys"
      "dotnet-sdk"
      "raycast"
      "fontforge"
    ];
    taps = [
      "azure/azd"
      "scalacenter/bloop"
    ];
    brews = [
      "azd"
      "opam"
      "tree"
      "yabai"
      "azure-cli"
      "rustup"
      "go"
      "scalacenter/bloop/bloop"
      "openjdk@17"
      "libuv"
      "pipx"
      "sbt"
    ];
  };
}
