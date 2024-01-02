return {
	"johmsalas/text-case.nvim",
	dependencies = { "nvim-telescope/telescope.nvim" },
	config = require("mike.config.textcase").init,
	keys = require("mike.config.textcase").keys,
}
