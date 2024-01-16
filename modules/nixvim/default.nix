{ pkgs, ... }: {
  # Import all your configuration modules here
  imports = [
    # ./configs/bufferline.nix
    ./configs/conform.nix
    ./configs/dap.nix
    ./configs/gitsigns.nix
    # ./configs/harpoon.nix
    ./configs/lualine.nix
    ./configs/lspconfig.nix
    ./configs/noice.nix
    ./configs/notify.nix
    ./configs/nvim-cmp.nix
    ./configs/telescope.nix
    ./configs/which-key.nix
  ];

  config = {
    options = {
      number = true;
      relativenumber = true;

      expandtab = true;
      hlsearch = false;

      scrolloff = 8;
      signcolumn = "yes";
      shiftwidth = 2;
      smartindent = true;
      smarttab = true;
      softtabstop = 2;
      termguicolors = true;
      wrap = false;
    };

    globals.mapleader = " ";

    extraConfigLua = ''
      vim.cmd("set colorcolumn=120")
      vim.o[clipboard] = "unnamedplus"
      vim.opt.nu = true
    '';

    colorschemes = {
      catppuccin = {
        enable = true;
        flavour = "macchiato";
        terminalColors = true;
        transparentBackground = true;

        integrations = {
          cmp = true;
          gitsigns = true;
          treesitter = true;
          fidget = true;
          harpoon = true;
          noice = true;
          notify = true;
          which_key = true;

          telescope = { enabled = true; };
          native_lsp.enabled = true;
        };
      };
    };

    plugins = {
      comment-nvim.enable = true;
      fidget.enable = true;
      fugitive.enable = true;
      lsp-format.enable = true;
      luasnip = { enable = true; };
      treesitter = { enable = true; };
    };

    extraPlugins = [{
      plugin = pkgs.vimPlugins.harpoon2;
      config = ''lua require("harpoon"):setup()'';
    }];

    keymaps = [
      {
        action = "<cmd>Explore<CR>";
        key = "<leader>pv";
        options = { desc = "Explore"; };
      }
      {
        action = "<cmd>Git<CR>";
        key = "<leader>gi";
        options = { desc = "Git UI"; };
      }
      {
        action = ":m '>+1<CR>gv=gv";
        key = "J";
        mode = [ "v" ];
      }
      {
        action = ":m '<-2<CR>gv=gv";
        key = "K";
        mode = [ "v" ];
      }
      {
        action =
          "<cmd>lua require('harpoon').ui:toggle_quick_menu(require('harpoon'):list())<CR>";
        key = "<leader>hm";
        options = { desc = "Harpoon Menu"; };
        mode = [ "n" ];
      }
      {
        action = "<cmd>lua require('harpoon'):list():append()<CR>";
        key = "<leader>ha";
        options = { desc = "Harpoon Add File"; };
        mode = [ "n" ];
      }
      {
        action = "<cmd>lua require('harpoon'):list():select(1)<CR>";
        key = "<C-h>";
        options = { desc = "Harpoon Goto 1"; };
        mode = [ "n" ];
      }
      {
        action = "<cmd>lua require('harpoon'):list():select(2)<CR>";
        key = "<C-j>";
        options = { desc = "Harpoon Goto 2"; };
        mode = [ "n" ];
      }
      {
        action = "<cmd>lua require('harpoon'):list():select(3)<CR>";
        key = "<C-k>";
        options = { desc = "Harpoon Goto 3"; };
        mode = [ "n" ];
      }
      {
        action = "<cmd>lua require('harpoon'):list():select(4)<CR>";
        key = "<C-l>";
        options = { desc = "Harpoon Goto 4"; };
        mode = [ "n" ];
      }
    ];
  };
}
