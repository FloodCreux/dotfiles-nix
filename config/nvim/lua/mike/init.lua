local function init()
	require("mike.config.vim").init()
	-- local plugins = require("mike.plugins")
	local opts = {}

	require("lazy").setup("mike.plugins", opts)
	require("mike.config.cmp").init()
	require("mike.config.git").init()
end

return {
	init = init,
}
