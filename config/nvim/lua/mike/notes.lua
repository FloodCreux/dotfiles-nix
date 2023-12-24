local function init()
	local neorg = require("neorg")
	local map = vim.keymap.set

	neorg.setup({
		load = {
			["core.defaults"] = {}, -- Loads default behavior
			["core.concealer"] = {}, -- Adds icons
			["core.summary"] = {},
			["core.completion"] = {
				config = {
					engine = "nvim-cmp",
				},
			},
			["core.dirman"] = {
				config = {
					workspaces = {
						work = "~/notes/work",
						personal = "~/notes/personal",
					},
					index = "index.norg",
				},
			},
		},
	})

	map("n", "<leader>nww", ":Neorg workspace work<CR>", { desc = "Open work notes workspace" })
	map("n", "<leader>nwp", ":Neorg workspace personal<CR>", { desc = "Open personal notes workspace" })
	map("n", "<leader>nx", ":Neorg return<CR>", { desc = "Close Neorg buffers" })
end

return {
	init = init,
}
