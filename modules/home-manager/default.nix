{ inputs }: { git }: { pkgs, ... }:

let
  catppuccin-bat = pkgs.fetchFromGitHub {
    owner = "catppuccin";
    repo = "bat";
    rev = "ba4d16880d63e656acced2b7d4e034e4a93f74b1";
    sha256 = "sha256-6WVKQErGdaqb++oaXnY3i6/GuH2FhTgK0v4TN4Y0Wbw=";
  };
  pkgsUnstable = inputs.nixpkgs-unstable.legacyPackages.${pkgs.system};
in
{
  #--------------------------------------------------------
  # home
  #--------------------------------------------------------

  # Don't change this
  home.stateVersion = "23.05";

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

  #--------------------------------------------------------
  # programs
  #--------------------------------------------------------

  programs.bat = {
    enable = true;
    config = { theme = "catppuccin"; };
    themes = {
      catppuccin = builtins.readFile
        (catppuccin-bat + "/Catppuccin-macchiato.tmTheme");
    };
  };

  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.exa.enable = true;
  programs.git.enable = true;

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    enableAutosuggestions = true;
    enableSyntaxHighlighting = true;

    shellAliases = {
      ls = "ls --color=auto -F";
      nixswitch = "darwin-rebuild switch --flake ~/personal/nix/.#default";
      nixup = "pushd ~/personal/nix; nix flake update; nixswitch; popd";
    };
  };

  programs.starship = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.wezterm = {
    enable = true;
    extraConfig = builtins.readFile ./dotfiles/wezterm.lua;
  };

  programs.tmux = {
    enable = true;
    extraConfig = builtins.readFile ./dotfiles/tmux.conf;
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
      # Git related plugins
      vimPlugins.vim-fugitive
      vimPlugins.vim-rhubarb
      vimPlugins.gitsigns-nvim
      vimPlugins.git-worktree-nvim

      # Detect tabstop and shiftwidth automatically
      vimPlugins.vim-sleuth
      #vim-editorconfig # Need to find the right one

      # Lsp configuration
      vimPlugins.nvim-lspconfig

      vimPlugins.comment-nvim

      vimPlugins.nvim-autopairs
      vimPlugins.cmp-nvim-lsp
      vimPlugins.nvim-cmp
      vimPlugins.luasnip

      vimPlugins.which-key-nvim

      vimPlugins.catppuccin-nvim

      vimPlugins.lualine-nvim
      vimPlugins.neodev-nvim

      vimPlugins.nvim-metals

      vimPlugins.nvim-treesitter.withAllGrammars
      vimPlugins.nvim-treesitter-context

      vimPlugins.plenary-nvim

      vimPlugins.telescope-nvim
      vimPlugins.telescope-fzf-native-nvim
      vimPlugins.telescope-file-browser-nvim

      # debugging
      vimPlugins.nvim-dap
      vimPlugins.nvim-dap-ui
      vimPlugins.nvim-dap-virtual-text

      vimPlugins.harpoon
      vimPlugins.refactoring-nvim

      vimPlugins.nvim-notify
      vimPlugins.nui-nvim
      vimPlugins.noice-nvim
      vimPlugins.persistence-nvim
      vimPlugins.todo-comments-nvim
      vimPlugins.indent-blankline-nvim

      vimPlugins.toggleterm-nvim

      vimPlugins.nvim-web-devicons

      pkgsUnstable.vimPlugins.conform-nvim

      vimPlugins.symbols-outline-nvim

      # extras
      vimPlugins.vim-be-good
      vimPlugins.vim-dadbod
      vimPlugins.vim-dadbod-ui
      vimPlugins.vim-dadbod-completion
      vimPlugins.ChatGPT-nvim
      vimPlugins.copilot-lua
      vimPlugins.neorg
      vimPlugins.dashboard-nvim
      vimPlugins.fidget-nvim

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
      pkgsUnstable.roslyn
      pkgs.omnisharp-roslyn
      pkgs.metals
      pkgs.yaml-language-server

      # formatters
      pkgs.nixpkgs-fmt
      pkgs.rustfmt
      pkgs.scalafmt
      # csharpier

      # tools
      pkgsUnstable.cargo
      pkgs.fd
      pkgs.gcc
      pkgs.ghc
    ];
  };
}

