local term = require 'toggleterm'

local function init()
    term.setup {}

    local map = vim.keymap.set

    map('n', '<leader>td', '<cmd>ToggleTerm direction=horizontal<cr>', { desc = 'Open a horizontal terminal' })
	map('n', '<leader>tf', '<cmd>ToggleTerm direction=float<cr>', { desc = 'Open a horizontal terminal' })
	map('n', '<leader>tv', '<cmd>ToggleTerm direction=vertical<cr>', { desc = 'Open a horizontal terminal' })

end

return {
    init = init
}
