return {
	"glepnir/dashboard-nvim",
	event = "VimEnter",
	dependencies = { { "nvim-tree/nvim-web-devicons" } },
	config = require("mike.config.dashboard").init,
}
