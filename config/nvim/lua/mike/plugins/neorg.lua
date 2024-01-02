return {
	"nvim-neorg/neorg",
	build = ":Neorg sync-parsers",
	dependencies = {
		"nvim-lua/plenary.nvim",
	},
	config = require("mike.config.notes").init,
}
