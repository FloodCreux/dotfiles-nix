local function init()
	local telescope = require("telescope")
	local builtin = require("telescope.builtin")

	telescope.setup({
		defaults = {
			file_ignore_patterns = {
				"node_modules/.*",
				"%.pem",
				".git/.*",
			},
			mappings = {
				i = {
					["<C-u>"] = false,
					["<C-d>"] = false,
				},
			},
		},
		extensions = {
			file_browser = {
				hijack_netrw = true,
				mappings = {
					["i"] = {},
					["n"] = {},
				},
			},
		},
		find_files = {
			hidden = true,
		},
	})

	telescope.load_extension("fzf")
	telescope.load_extension("file_browser")
	telescope.load_extension("metals")

	vim.keymap.set("n", "<leader>ff", builtin.oldfiles, { desc = "[?] Find recently opened files" })
	vim.keymap.set("n", "<leader><space>", builtin.buffers, { desc = "[ ] Find existing buffers" })
	vim.keymap.set("n", "<leader>/", function()
		-- You can pass additional configuration to telescope to change theme, layout, etc.
		builtin.current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
			winblend = 10,
			previewer = false,
		}))
	end, { desc = "[/] Fuzzily search in current buffer" })

	vim.keymap.set("n", "<leader>gf", builtin.git_files, { desc = "Search Git Files" })
	vim.keymap.set("n", "<leader>sf", function()
		builtin.find_files({ hidden = true })
	end, { desc = "Search Files" })
	vim.keymap.set("n", "<leader>sh", builtin.help_tags, { desc = "Search Help" })
	vim.keymap.set("n", "<leader>sw", builtin.grep_string, { desc = "Search current Word" })
	vim.keymap.set("n", "<leader>sg", builtin.live_grep, { desc = "Search by Grep" })
	vim.keymap.set("n", "<leader>sd", builtin.diagnostics, { desc = "Search Diagnostics" })
	vim.keymap.set("n", "<leader>sr", builtin.resume, { desc = "Search Resume" })
	vim.keymap.set("n", "<leader>gd", builtin.lsp_definitions, { desc = "Goto Definition" })
end

return {
	init = init,
}
