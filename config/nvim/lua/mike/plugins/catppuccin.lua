return {
	"catppuccin/nvim",
	name = "catppuccin",
	priority = 1000,
	config = function()
		local catppuccin = require("catppuccin")
		catppuccin.setup({
			flavour = "macchiato",
			integrations = {
				gitsigns = true,
				native_lsp = {
					enabled = true,
				},
				telescope = true,
				treesitter = true,
			},
			term_colors = true,
			transparent_background = true,
		})

		vim.cmd.colorscheme("catppuccin-macchiato")
	end,
}
