{ inputs }:
{ git }:
{ pkgs, ... }:

let
  catppuccin-bat = pkgs.fetchFromGitHub {
    owner = "catppuccin";
    repo = "bat";
    rev = "ba4d16880d63e656acced2b7d4e034e4a93f74b1";
    sha256 = "sha256-6WVKQErGdaqb++oaXnY3i6/GuH2FhTgK0v4TN4Y0Wbw=";
  };
  pkgsUnstable = inputs.nixpkgs-unstable.legacyPackages.${pkgs.system};
in {
  #--------------------------------------------------------
  # home
  #--------------------------------------------------------

  # Don't change this
  home.stateVersion = "23.11";

  # specify home manager configs
  home.packages = [
    pkgs.ripgrep
    pkgs.fd
    pkgs.curl
    pkgs.less
    pkgs.gh
    pkgs.jq
    pkgs.coursier
    pkgs.maven
    pkgs.zsh
    pkgs.jdk8

    pkgsUnstable.rustc
    pkgsUnstable.cargo
  ];

  home.sessionVariables = {
    PAGER = "less";
    CLICLOLOR = 1;
    EDITOR = "nvim";
  };

  home.file.".inputrc".source = ./dotfiles/inputrc;
  home.file.".config/nvim/after/ftplugin/markdown.vim".text = ''
    setlocal wrap
  '';

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
    ];
    shell = "${pkgs.zsh}/bin/zsh";
    terminal = "screen-256color";
  };

  programs.direnv = {
    enable = true;
    enableZshIntegration = true;
    nix-direnv.enable = true;
  };

  programs.neovim = {
    enable = true;

    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;

    plugins = with pkgs; [
      vimPlugins.lazy-nvim
      inputs.self.packages.${pkgs.system}.mike-nvim
    ];

    extraLuaConfig = ''
      require('mike').init()
    '';

    extraPackages = [
      # languages
      pkgsUnstable.rustc
      pkgs.scala_2_12
      pkgs.ocaml
      pkgs.go
      pkgs.zig

      # language servers
      pkgs.lua-language-server
      pkgs.nil
      pkgs.rust-analyzer
      pkgs.terraform-ls
      pkgs.roslyn
      pkgs.omnisharp-roslyn
      pkgs.metals
      pkgs.yaml-language-server
      pkgs.ocamlPackages.ocaml-lsp
      pkgs.ocamlPackages.merlin
      pkgs.clang

      # formatters
      pkgs.nixpkgs-fmt
      pkgs.nixfmt
      pkgs.rustfmt
      pkgs.scalafmt
      pkgs.ocamlformat
      # csharpier
      pkgs.prettierd
      pkgs.nodePackages.prettier
      pkgs.nodePackages.sql-formatter
      pkgs.isort
      pkgs.stylua
      pkgs.uncrustify

      # tools
      pkgs.cargo
      pkgs.fd
      pkgs.gcc
      pkgs.ghc
    ];
  };

  programs.alacritty = { enable = true; };
}

