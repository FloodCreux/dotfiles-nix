{ inputs }:
{ system }:
{ pkgs, ... }:
let
  catppuccin-bat = pkgs.fetchFromGitHub {
    owner = "catppuccin";
    repo = "bat";
    rev = "ba4d16880d63e656acced2b7d4e034e4a93f74b1";
    sha256 = "sha256-6WVKQErGdaqb++oaXnY3i6/GuH2FhTgK0v4TN4Y0Wbw=";
  };
in {
  #--------------------------------------------------------
  # home
  #--------------------------------------------------------

  # Don't change this unless you know what you're doing
  home.stateVersion = "23.11";

  # specify home manager configs
  home.packages = [
    inputs.nixvim.packages.${system}.default

    pkgs.ripgrep
    pkgs.fd
    pkgs.curl
    pkgs.less
    pkgs.gh
    pkgs.jq
    pkgs.zsh
    pkgs.skhd
    pkgs.gimp

    # Git
    pkgs.lazygit
    pkgs.gitkraken

    # Rust
    pkgs.rustc
    pkgs.rustfmt
    pkgs.cargo

    # C
    pkgs.gcc
    pkgs.ghc
    pkgs.cmake

    # Scala
    # pkgs.jetbrains.idea-community
    pkgs.metals
    pkgs.coursier
    pkgs.maven
    pkgs.scala_2_12
    pkgs.scalafmt

    # OCaml
    pkgs.ocaml

    # Go
    pkgs.go

    # Nix
    pkgs.nixfmt

    # Zig
    pkgs.zig

    # Haskell
    pkgs.elixir

    # .NET
    # pkgs.jetbrains.rider
    pkgs.dotnet-sdk_8
    pkgs.omnisharp-roslyn
    pkgs.roslyn

    # Sql
    pkgs.sqlite

    # Containers
    pkgs.docker

    pkgs.nodePackages.vscode-json-languageserver

    pkgs.snyk

  ];

  home.sessionVariables = {
    PAGER = "less";
    CLICLOLOR = 1;
    EDITOR = "nvim";
  };

  home.file.".inputrc".source = ./dotfiles/inputrc;

  home.file.".config/alacritty/alacritty.yml".source =
    ./dotfiles/alacritty/alacritty.yml;
  home.file.".config/alacritty/catppuccin-macchiato.yml".source =
    ./dotfiles/alacritty/catppuccin-macchiato.yml;

  home.file.".zsh/starship.zsh".source = ./dotfiles/zsh/starship.zsh;
  home.file.".zsh/aliases.zsh".source = ./dotfiles/zsh/aliases.zsh;

  home.file.".local/scripts/tmux-sessionizer".source =
    ./scripts/tmux/tmux-sessionizer.sh;
  home.file.".local/scripts/tmux-cht.sh".source = ./scripts/tmux/tmux-cht.sh;
  home.file.".tmux-cht-languages".source = ./dotfiles/tmux/.tmux-cht-languages;
  home.file.".tmux-cht-command".source = ./dotfiles/tmux/.tmux-cht-command;

  home.file.".config/starship.toml".source = ./dotfiles/starship/starship.toml;

  home.file.".config/skhd/skhdrc" = {
    source = ./dotfiles/skhd/skhdrc;
    executable = true;
  };

  home.file.".config/yabai/yabairc" = {
    source = ./dotfiles/yabai/yabairc;
    executable = true;
  };

  home.file.".config/zellij/config.kdl" = {
    source = ./dotfiles/zellij/config.kdl;
    executable = true;
  };

  home.file.".gitkraken/themes/catppuccin-macchiato-theme.jsonc" = {
    source = ./dotfiles/gitkraken/themes/catppuccin-macchiato-theme.jsonc;
    executable = true;
  };

  home.file.".gitkraken/themes/catppuccin-mocha-theme.jsonc" = {
    source = ./dotfiles/gitkraken/themes/catppuccin-mocha-theme.jsonc;
    executable = true;
  };

  #--------------------------------------------------------
  # programs
  #--------------------------------------------------------

  programs.bat = {
    enable = true;
    config = { theme = "catppuccin"; };
    themes = {
      catppuccin =
        builtins.readFile (catppuccin-bat + "/Catppuccin-macchiato.tmTheme");
    };
  };

  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.eza.enable = true;
  programs.git.enable = true;

  programs.java = {
    enable = true;
    package = pkgs.jdk8;
  };

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    enableAutosuggestions = true;
    syntaxHighlighting = { enable = true; };

    shellAliases = {
      nixswitch = "darwin-rebuild switch --flake ~/personal/nix/.#default";
      nixup = "pushd ~/personal/nix; nix flake update; nixswitch; popd";
    };

    initExtra = ''
      [[ -f ~/.zsh/aliases.zsh ]] && source ~/.zsh/aliases.zsh
      [[ -f ~/.zsh/starship.zsh ]] && source ~/.zsh/starship.zsh
      export LIBRARY_PATH=$LIBRARY_PATH:$(brew --prefix)/lib:$(brew --prefix)/opt/libiconv/lib
    '';
  };

  programs.starship = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.wezterm = {
    enable = true;
    extraConfig = builtins.readFile ./dotfiles/wezterm/wezterm.lua;
  };

  programs.tmux = {
    enable = true;
    extraConfig = builtins.readFile ./dotfiles/tmux/tmux.conf;
    plugins = with pkgs; [
      tmuxPlugins.catppuccin
      tmuxPlugins.vim-tmux-navigator
      tmuxPlugins.resurrect
    ];
    shell = "${pkgs.zsh}/bin/zsh";
    terminal = "screen-256color";
  };

  programs.zellij = { enable = true; };

  programs.direnv = {
    enable = true;
    enableZshIntegration = true;
    nix-direnv.enable = true;
  };

  programs.password-store = {
    enable = true;
    settings = { PASSWORD_STORE_DIR = "~/.password-store"; };
  };
}

