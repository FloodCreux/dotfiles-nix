local function init()
    local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
    if not vim.loop.fs_stat(lazypath) then
        vim.fn.system({
            "git",
            "clone",
            "--filter=blob:none",
            "https://github.com/folke/lazy.nvim.git",
            "--branch=stable",
            lazypath
        })
    end

    vim.opt.rtp:prepend(lazypath)
end

local function install()
    -- require 'mike.dashboard'.init()
    -- require 'mike.dap'.init()
    -- require 'mike.which-key'.init()
    -- require 'mike.theme'.init()
    -- require 'mike.languages'.init()
    -- require 'mike.chatgpt'.init()
    -- require 'mike.telescope'.init()
    -- require 'mike.terminal'.init()
    -- require 'mike.metals'.init()
    -- require 'mike.git'.init()
    -- require 'mike.noice'.init()
    -- require 'mike.cmp'.init()
    -- require 'mike.conform'.init()
    -- require 'mike.harpoon'.init()
    -- require 'mike.database'.init()
    -- require 'mike.notes'.init()
    -- require 'mike.comment'.init()
    require('lazy').setup({
        'tpope/vim-fugitive',
        'tpope/vim-rhubarb',
        'tpope/vim-sleuth',
        'sgur/vim-editorconfig',
        {
            -- Add indentation guides even on blank lines
            'lukas-reineke/indent-blankline.nvim',
            -- Enable `lukas-reineke/indent-blankline.nvim`
            -- See `:help indent_blankline.txt`
            main = "ibl",
            opts = {},
            config = require('mike.indent').config,
        },

        { 'numToStr/Comment.nvim', opts = {} },
        {
            'nvim-telescope/telescope.nvim',
            branch = '0.1.x',
            dependencies = {
                'nvim-lua/plenary.nvim',
                -- Fuzzy Finder Algorithm which requires local dependencies to be built.
                -- Only load if `make` is available. Make sure you have the system
                -- requirements installed.
                {
                    'nvim-telescope/telescope-fzf-native.nvim',
                    -- NOTE: If you are having trouble with this installation,
                    --       refer to the README for telescope-fzf-native for more instructions.
                    build = 'make',
                    cond = function()
                        return vim.fn.executable 'make' == 1
                    end,
                },
            },
        },

        {
            -- Highlight, edit, and navigate code
            'nvim-treesitter/nvim-treesitter',
            dependencies = {
                'nvim-treesitter/nvim-treesitter-textobjects',
            },
            build = ':TSUpdate',
        },
        { 'folke/which-key.nvim',  opts = {} },
        {
            'catppuccin/nvim',
            name = "catppuccin",
            priority = 1000,
            config = function()
                require 'mike.catppuccin'.config()
            end,
        },
        {
            -- Set lualine as statusline
            'nvim-lualine/lualine.nvim',
            config = require 'mike.lualine'.init,
        },
        {
            -- LSP Configuration & Plugins
            'neovim/nvim-lspconfig',
            dependencies = {
                -- Useful status updates for LSP
                -- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
                { 'j-hui/fidget.nvim', tag = 'legacy', opts = {} },

                -- Additional lua configuration, makes nvim stuff amazing!
                'folke/neodev.nvim',
            },
        },
        {
            -- Autocompletion
            'hrsh7th/nvim-cmp',
            dependencies = require('mike.cmp').dependencies,
        },

        {
            -- Adds git related signs to the gutter, as well as utilities for managing changes
            'lewis6991/gitsigns.nvim',
            opts = {
                signs = {
                    add = { text = '+' },
                    change = { text = '~' },
                    delete = { text = '_' },
                    topdelete = { text = '‾' },
                    changedelete = { text = '~' },
                },
                on_attach = function(bufnr)
                    vim.keymap.set('n', '<leader>gh', require('gitsigns').preview_hunk,
                        { buffer = bufnr, desc = 'Preview git hunk' })

                    -- don't override the built in and fugitive keymaps
                    local gs = package.loaded.gitsigns

                    vim.keymap.set({ 'n', 'v' }, ']c', function()
                        if vim.wo.diff then return ']c' end
                        vim.schedule(function() gs.next_hunk() end)
                        return '<Ignore>'
                    end, { expr = true, buffer = bufnr, desc = "Jump to next hunk" })
                    vim.keymap.set({ 'n', 'v' }, '[c', function()
                        if vim.wo.diff then return '[c' end
                        vim.schedule(function() gs.prev_hunk() end)
                        return '<Ignore>'
                    end, { expr = true, buffer = bufnr, desc = "Jump to previous hunk" })

                    vim.keymap.set('n', '<leader>gsh', gs.stage_hunk, { desc = 'Git stage hunk' })
                    vim.keymap.set('n', '<leader>gsb', gs.stage_buffer, { desc = 'Git stage buffer' })
                    vim.keymap.set('n', '<leader>gsu', gs.undo_stage_hunk, { desc = 'Git undo stage hunk' })
                    vim.keymap.set('n', '<leader>gsr', gs.reset_buffer, { desc = 'Git reset buffer' })
                    vim.keymap.set('n', '<leader>gsp', gs.preview_hunk, { desc = 'Git preview hunk' })

                    vim.keymap.set('n', '<leader>gpp', ':Git push ', { desc = 'Git push' })
                    vim.keymap.set('n', '<leader>gpr', ':Git rebase origin ', { desc = 'Git rebase origin' })
                end
            },
        },

        {
            'ThePrimeagen/git-worktree.nvim',
            -- config = function() require 'mike.git-worktree'.config() end,
        },
        {
            'folke/noice.nvim',
            event = 'VeryLazy',
            opts = {},
            config = require('mike.noice').init,
            dependencies = {
                'MunifTanjim/nui.nvim',
                'rcarriga/nvim-notify',
            },
        },
        {
            'folke/persistence.nvim',
            events = 'BufReadPre',
            opts = {
                options = {
                    'buffers',
                    'curdir',
                    'tabpages',
                    'winsize',
                    'help',
                    'globals',
                    'skiprtp'
                }
            },
            keys = {
                { '<leader>qs', function() require('persistence').load() end, desc = "Restore Session" },
                {
                    '<leader>ql',
                    function() require('persistence').load({ last = true }) end,
                    desc =
                    "Restore Last Session"
                },
                {
                    '<leader>qd',
                    function() require('persistence').stop() end,
                    desc =
                    "Don't Save Current Session"
                },
            },
        },
        {
            'folke/todo-comments.nvim',
            dependencies = { 'nvim-lua/plenary.nvim' },
            opts = {},
        },
        {
            'akinsho/toggleterm.nvim',
            version = '*',
            config = require('mike.terminal').init,
            keys = {
                { "<leader>td", "<cmd>ToggleTerm direction=horizontal<cr>", desc = "Open a horizontal terminal" },
                { "<leader>tf", "<cmd>ToggleTerm direction=float<cr>",      desc = "Open a horizontal terminal" },
                { "<leader>tv", "<cmd>ToggleTerm direction=vertical<cr>",   desc = "Open a horizontal terminal" },
            },
        },
        {
            'glepnir/dashboard-nvim',
            event = 'VimEnter',
            dependencies = { { 'nvim-tree/nvim-web-devicons' } },
            config = require 'mike.dashboard'.init,
        },
        {
            'nvim-telescope/telescope-file-browser.nvim',
            dependencies = {
                'nvim-telescope/telescope.nvim',
                'nvim-lua/plenary.nvim'
            }
        },
        {
            'stevearc/conform.nvim',
            config = require 'mike.conform'.init,
        },
        {
            'scalameta/nvim-metals',
            config = require 'mike.metals'.init,
            dependencies = {
                'nvim-lua/plenary.nvim',
                'mfussenegger/nvim-dap',
            },
        },
        {
            'mfussenegger/nvim-dap',
            dependencies = {
                -- Creates a beautiful debugger UI
                'rcarriga/nvim-dap-ui',

                -- Installs the debug adapters for you
                'williamboman/mason.nvim',
                'jay-babu/mason-nvim-dap.nvim',

                -- Add your own debuggers here
                'leoluz/nvim-dap-go',
            },
            config = require 'mike.dap'.init,
        }
    })
end

return {
    init = init,
    install = install,
}
