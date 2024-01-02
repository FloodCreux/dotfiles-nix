return {
	"jackMort/ChatGPT.nvim",
	config = require("mike.config.chatgpt").init,
	dependencies = {
		"MunifTanjim/nui.nvim",
		"nvim-lua/plenary.nvim",
		"nvim-telescope/telescope.nvim",
	},
}
