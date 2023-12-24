local function init()
	local textcase = require("textcase")
	local telescope = require("telescope")

	textcase.setup({})
	telescope.load_extension("textcase")
end

local keys = {
	{ "ga.", "<cmd>TextCaseOpenTelescope<CR>", mode = { "n", "v" }, desc = "Textcase Telescope" },
}

return {
	init = init,
	keys = keys,
}
