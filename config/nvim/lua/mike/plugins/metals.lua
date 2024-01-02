return {
	"scalameta/nvim-metals",
	config = require("mike.config.metals").init,
	dependencies = {
		"nvim-lua/plenary.nvim",
		"mfussenegger/nvim-dap",
	},
}
