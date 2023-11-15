{ inputs }: { git }: {pkgs, ...}:

let
    catppuccin-bat = pkgs.fetchFromGitHub {
        owner = "catppuccin";
        repo = "bat";
        rev = "ba4d16880d63e656acced2b7d4e034e4a93f74b1";
        sha256 = "sha256-6WVKQErGdaqb++oaXnY3i6/GuH2FhTgK0v4TN4Y0Wbw=";
    };
in 
{
    #--------------------------------------------------------
    # home
    #--------------------------------------------------------

    # Don't change this
    home.stateVersion = "23.05";

    # specify home manager configs
    home.packages = with pkgs; [ 
        ripgrep 
        fd 
        curl 
        less 
        gh
        jq
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
            nixswitch = "darwin-rebuild switch --flake ~/.config/nix/.#";
            nixup = "pushd ~/.config/nix flake update; nixswitch; popd";
        };
    };

    programs.starship = {
        enable = true;
        enableZshIntegration = true;
    };

    programs.wezterm = {
        enable = true;
    };

    programs.tmux = {
        enable = true;
        extraConfig = ''
            set-option -a terminal-overrides ",*256col*;RGB";
        '';
        plugins = with pkgs; [ tmuxPlugins.catppuccin ];
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
            vimPlugins.nvim-cmp
            vimPlugins.which-key-nvim

            vimPlugins.catppuccin-nvim

            vimPlugins.lualine-nvim

            vimPlugins.nvim-metals

            vimPlugins.nvim-treesitter.withAllGrammars
            vimPlugins.nvim-treesitter-context

            vimPlugins.plenary-nvim

            vimPlugins.telescope-nvim
            vimPlugins.telescope-fzf-native-nvim
            vimPlugins.telescope-file-browser-nvim

            vimPlugins.nvim-dap

            vimPlugins.harpoon
            vimPlugins.refactoring-nvim

            vimPlugins.nvim-notify
            vimPlugins.nui-nvim
            vimPlugins.noice-nvim
            vimPlugins.persistence-nvim
            vimPlugins.todo-comments-nvim

            vimPlugins.toggleterm-nvim

            vimPlugins.nvim-web-devicons

            # conform-nvim

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

            inputs.self.packages.${pkgs.system}.mike-nvim
        ];

        extraPackages = with pkgs; [
            # languages
            rustc
            scala
            ocaml
            go
            zig

            # language servers
            lua-language-server
            nil
            rust-analyzer
            terraform-ls
            # csharp-ls

            # formatters
            nixpkgs-fmt
            rustfmt
            scalafmt
            # csharpier
        ];
    };
}

