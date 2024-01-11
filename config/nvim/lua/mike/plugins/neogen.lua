return {
	"danymat/neogen",
	dependencies = "nvim-treesitter/nvim-treesitter",
	config = function()
		require("neogen").setup({
			snippet_engine = "luasnip",
		})

		local opts = { desc = "Generate documentation" }
		vim.keymap.set("n", "<leader>dc", ":lua require('neogen').generate()<CR>", opts)
	end,
}
