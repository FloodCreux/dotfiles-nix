return {
	"folke/noice.nvim",
	event = "VeryLazy",
	opts = {},
	config = require("mike.config.noice").init,
	dependencies = {
		"MunifTanjim/nui.nvim",
		"rcarriga/nvim-notify",
	},
}
