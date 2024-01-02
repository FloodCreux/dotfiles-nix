local function config()
	local cyberdream = require("cyberdream")

	cyberdream.setup({
		transparent = true,
		italic_comments = true,
		hide_fillchars = true,
	})

	-- vim.cmd.colorscheme("cyberdream")
end

return {
	config = config,
}
