local function init()
	local plugins = require("mike.plugins")
	local opts = {}

	require("lazy").setup(plugins, opts)
end

return {
	init = init,
}
