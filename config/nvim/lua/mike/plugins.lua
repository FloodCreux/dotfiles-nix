return {
	"tpope/vim-fugitive",
	"tpope/vim-rhubarb",
	"tpope/vim-sleuth",
	"sgur/vim-editorconfig",
	{
		-- Highlight, edit, and navigate code
		"nvim-treesitter/nvim-treesitter",
		dependencies = {
			"nvim-treesitter/nvim-treesitter-textobjects",
			"nvim-treesitter/nvim-treesitter-context",
		},
		build = ":TSUpdate",
		config = require("mike.treesitter").init,
	},
	{
		-- Add indentation guides even on blank lines
		"lukas-reineke/indent-blankline.nvim",
		-- Enable `lukas-reineke/indent-blankline.nvim`
		-- See `:help indent_blankline.txt`
		main = "ibl",
		opts = {},
		config = require("mike.indent").config,
	},

	{
		"numToStr/Comment.nvim",
		opts = {},
		config = require("mike.comment").init,
	},
	{
		"nvim-telescope/telescope.nvim",
		branch = "0.1.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			-- Fuzzy Finder Algorithm which requires local dependencies to be built.
			-- Only load if `make` is available. Make sure you have the system
			-- requirements installed.
			{
				"nvim-telescope/telescope-fzf-native.nvim",
				-- NOTE: If you are having trouble with this installation,
				--       refer to the README for telescope-fzf-native for more instructions.
				build = "make",
				cond = function()
					return vim.fn.executable("make") == 1
				end,
			},
		},
		config = require("mike.telescope").init,
	},
	{
		"lewis6991/hover.nvim",
		config = require("mike.hover").init,
	},
	{
		"folke/which-key.nvim",
		config = require("mike.which-key").init,
		opts = {},
	},
	{
		"catppuccin/nvim",
		name = "catppuccin",
		priority = 1000,
		config = function()
			require("mike.catppuccin").config()
		end,
	},
	{
		-- Set lualine as statusline
		"nvim-lualine/lualine.nvim",
		dependencies = {
			"nvim-tree/nvim-web-devicons",
		},
		config = require("mike.lualine").init,
	},
	{
		-- LSP Configuration & Plugins
		"neovim/nvim-lspconfig",
		dependencies = {
			-- Useful status updates for LSP
			-- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
			{ "j-hui/fidget.nvim", tag = "legacy", opts = {} },

			-- Additional lua configuration, makes nvim stuff amazing!
			"folke/neodev.nvim",
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
		},
		config = require("mike.lspconfig").init,
	},
	{
		-- Autocompletion
		"hrsh7th/nvim-cmp",
		dependencies = require("mike.cmp").dependencies,
	},

	{
		-- Adds git related signs to the gutter, as well as utilities for managing changes
		"lewis6991/gitsigns.nvim",
		config = require("mike.git").gitsigns,
	},

	{
		"ThePrimeagen/git-worktree.nvim",
		config = require("mike.git").gitworktree,
	},
	{
		"theprimeagen/harpoon",
		branch = "harpoon2",
		config = require("mike.harpoon").init,
	},
	{
		"ThePrimeagen/refactoring.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-treesitter/nvim-treesitter",
		},
		config = require("mike.refactoring").init,
	},
	{
		"folke/noice.nvim",
		event = "VeryLazy",
		opts = {},
		config = require("mike.noice").init,
		dependencies = {
			"MunifTanjim/nui.nvim",
			"rcarriga/nvim-notify",
		},
	},
	{
		"folke/persistence.nvim",
		events = "BufReadPre",
		opts = {
			options = {
				"buffers",
				"curdir",
				"tabpages",
				"winsize",
				"help",
				"globals",
				"skiprtp",
			},
		},
		keys = {
			{
				"<leader>qs",
				function()
					require("persistence").load()
				end,
				desc = "Restore Session",
			},
			{
				"<leader>ql",
				function()
					require("persistence").load({ last = true })
				end,
				desc = "Restore Last Session",
			},
			{
				"<leader>qd",
				function()
					require("persistence").stop()
				end,
				desc = "Don't Save Current Session",
			},
		},
	},
	{
		"folke/todo-comments.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		opts = {},
	},
	{
		"akinsho/toggleterm.nvim",
		version = "*",
		config = true,
		keys = {
			{ "<leader>td", "<cmd>ToggleTerm direction=horizontal<cr>", desc = "Open a horizontal terminal" },
			{ "<leader>tf", "<cmd>ToggleTerm direction=float<cr>", desc = "Open a horizontal terminal" },
			{ "<leader>tv", "<cmd>ToggleTerm direction=vertical<cr>", desc = "Open a horizontal terminal" },
		},
	},
	{
		"glepnir/dashboard-nvim",
		event = "VimEnter",
		dependencies = { { "nvim-tree/nvim-web-devicons" } },
		config = require("mike.dashboard").init,
	},
	{
		"nvim-telescope/telescope-file-browser.nvim",
		dependencies = {
			"nvim-telescope/telescope.nvim",
			"nvim-lua/plenary.nvim",
		},
	},
	{
		"stevearc/conform.nvim",
		event = { "BufWritePre" },
		config = require("mike.conform").init,
	},
	{
		"scalameta/nvim-metals",
		config = require("mike.metals").init,
		dependencies = {
			"nvim-lua/plenary.nvim",
			"mfussenegger/nvim-dap",
		},
	},
	{
		"mfussenegger/nvim-dap",
		dependencies = {
			-- Creates a beautiful debugger UI
			"rcarriga/nvim-dap-ui",

			-- Installs the debug adapters for you
			"williamboman/mason.nvim",
			"jay-babu/mason-nvim-dap.nvim",

			-- Add your own debuggers here
			"leoluz/nvim-dap-go",
		},
		config = require("mike.dap").init,
	},
	{
		"zbirenbaum/copilot.lua",
		config = require("mike.copilot").init,
	},
	{
		"tpope/vim-dadbod",
		dependencies = {
			"kristijanhusak/vim-dadbod-ui",
			"kristijanhusak/vim-dadbod-completion",
		},
		config = require("mike.database").init,
	},
	{
		"jackMort/ChatGPT.nvim",
		config = require("mike.chatgpt").init,
		dependencies = {
			"MunifTanjim/nui.nvim",
			"nvim-lua/plenary.nvim",
			"nvim-telescope/telescope.nvim",
		},
	},
	{
		"nvim-neorg/neorg",
		build = ":Neorg sync-parsers",
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		config = require("mike.notes").init,
	},
	{
		"johmsalas/text-case.nvim",
		dependencies = { "nvim-telescope/telescope.nvim" },
		config = require("mike.textcase").init,
		keys = require("mike.textcase").keys,
	},
}
