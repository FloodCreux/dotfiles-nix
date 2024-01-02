return {
	"neovim/nvim-lspconfig",
	dependencies = {
		{ "j-hui/fidget.nvim", tag = "legacy", opts = {} },

		"folke/neodev.nvim",
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
	},
	config = require("mike.config.lspconfig").init,
}
