return {
	"akinsho/toggleterm.nvim",
	version = "*",
	config = true,
	keys = {
		{ "<leader>td", "<cmd>ToggleTerm direction=horizontal<cr>", desc = "Open a horizontal terminal" },
		{ "<leader>tf", "<cmd>ToggleTerm direction=float<cr>", desc = "Open a horizontal terminal" },
		{ "<leader>tv", "<cmd>ToggleTerm direction=vertical<cr>", desc = "Open a horizontal terminal" },
	},
}
